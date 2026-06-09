//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/redundantMemberwiseInit(rule:mode:)`` 的合成 init 偏好模式
	///
	/// 對應 swiftformat 的 `prefer-synthesized-init-for-internal-structs` option。本 enum
	/// 為 SwiftStyleKit 首個帶 associated value 的 ``FormatRuleOption``——`.conformances([String])`
	/// 的 associated value 為 SwiftUI protocol 名單（如 `["View", "ViewModifier"]`）、
	/// 規則只對 conform 這些 protocol 的 internal struct 做改寫。
	public enum PreferSynthesizedInitMode: FormatRuleOption {

		/// 保守模式：只移除明顯冗餘的 init（swiftformat 上游預設）
		case never

		/// 對所有 internal struct 把 private property 改 internal、讓 synthesized init 取代
		case always

		/// 只對 conform 指定 protocol 的 struct 做（如 `.conformances(["View", "ViewModifier"])`）
		case conformances([String])

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "preferSynthesizedInitForInternalStructs"

		public var cliValue: String {
			switch self {
			case .never: "never"
			case .always: "always"
			case let .conformances(list): list.joined(separator: ",")
			}
		}
	}
}
