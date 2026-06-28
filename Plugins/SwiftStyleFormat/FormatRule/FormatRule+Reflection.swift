//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {
	/// 將此 rule 展開為 swiftformat CLI 參數
	public var cliArguments: [String] { command }
}

extension FormatRule {
	/// 取得當前 storage case 的反射節點。force unwrap 收在此反射邊界、且安全：``Storage``
	/// 每個 case 都帶 payload（至少 `rule: Flag`），Mirror `children.first` 與其 `label` 必非 nil。
	private var currentCase: (label: String, value: Any) {
		let child = Mirror(reflecting: storage).children.first!
		return (child.label!, child.value)
	}

	/// 當前 storage case 的名稱（＝ swiftformat rule 名）
	///
	/// storage case 採乾淨命名（無 `_` 前綴）；對外名與型別安全由 ``FormatRule`` 的 static
	/// func 工廠提供，``Storage`` 本身 internal、不入對外 interface。
	private var name: String { currentCase.label }

	/// 反射展開出 CLI 參數
	private var command: [String] {
		var command: [String] = []
		for (label, raw) in Mirror(reflecting: currentCase.value).children {
			// Optional unwrap：nil 跳過、some 取 inner value（讓 case 簽名可帶 Optional option）
			let unwrapped: Any
			let optionalMirror: Mirror = .init(reflecting: raw)
			if optionalMirror.displayStyle == .optional {
				guard let first = optionalMirror.children.first else { continue }
				unwrapped = first.value
			} else {
				unwrapped = raw
			}

			if let ruleFlag = unwrapped as? Flag {
				// .disable case 整個不展開：Xcode 入口已注入 `--disable all`、後面
				// 再加 `--disable <name>` 是冗餘的 CLI 雜訊。改為 .disable 返空陣列、
				// 只有 .enable 才 append `--enable <name>` 與後續 option 展開
				guard case .enable = ruleFlag else { return [] }
				command.append(contentsOf: ["--\(ruleFlag)", name])
				continue
			}

			// 列表型 option（[String]）：空陣列視為「不覆寫」、與 nil 等效不展開；
			// 非空時逗號相連展成單一字串（swiftformat 預期 `--flag a,b,c` 格式）
			if let listValue = unwrapped as? [String] {
				guard !listValue.isEmpty else { continue }
				let joined = listValue.joined(separator: ",")
				let flag: String = if let label, !label.isEmpty, label.first != "." {
					label
				} else {
					name
				}
				command.append(contentsOf: ["--\(flag)", joined])
				continue
			}

			let option: String = switch unwrapped {
			// FormatRuleOption 優先：含「帶 associated value 的 enum」（如
			// PreferSynthesizedInitMode）需自訂 cliValue；String RawRepresentable
			// enum 由 default extension 取 rawValue
			case let value as any FormatRuleOption: value.cliValue
			case let value as any RawRepresentable<String>: value.rawValue
			case let value as Bool: value ? "true" : "false"
			case let value as Int: "\(value)"
			case let value as String: value
			default: ""
			}
			// option flag 名取得順序：型別自宣告（FormatRuleOption）> Swift label
			// > case 名。讓 case 簽名的參數 label 可取人類可讀名（如 `mode:`），
			// 與 swiftformat flag 名（如 `--blankLineAfterSwitchCase`）解耦
			let flag: String = if let ruleOption = unwrapped as? any FormatRuleOption {
				type(of: ruleOption).flagName
			} else if let label, !label.isEmpty, label.first != "." {
				label
			} else {
				// unnamed associated value：用 case 名稱當 option key
				name
			}
			command.append(contentsOf: ["--\(flag)", option])
		}
		return command
	}
}
