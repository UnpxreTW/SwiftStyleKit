//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import Foundation

// REUSE-IgnoreStart — 本檔通篇是「產生檔頭」的模板字串與範例，
// 非本檔自身的授權宣告（見上方檔頭）；不圈會被 reuse 誤抽成 invalid expression。

/// 檔案標頭組裝
///
/// 由 plugin 在執行期呼叫——`copyrightHolder` 與 `recognizeLicense` 解析使用端專案的
/// `LICENSE`，`header` 依結果組出傳給 swiftformat `--header` 的標頭字串。
public enum FileHeaderBuilder {

	// MARK: Public

	/// `LICENSE` 檔的辨識結果（僅授權類型；版權持有人改由 AUTHORS / 設定提供、與授權正交）
	public enum LicenseInfo {

		/// 無 `LICENSE` 檔
		case missing

		/// 有 `LICENSE` 檔、但授權類型未辨識
		case unrecognized

		/// 有 `LICENSE` 檔、授權類型已辨識
		case recognized(name: String, spdxID: String)
	}

	/// 從版權文字（`LICENSE` / `NOTICE`）抓版權持有人
	///
	/// 比對 `Copyright (©|(c)) <年份> <持有人>` 形式的版權行、取「持有人」段；容前導
	/// markdown 符號與 `<年份>-Present` 之類的非年份範圍尾，並剝除尾端的
	/// `All rights reserved`。找不到回 `nil`。
	public static func copyrightHolder(in licenseText: String) -> String? {
		let pattern = #/^[\s*#>]*copyright\s+(?:\([cC]\)\s+|©\s+)?\d{4}(?:\s*[-–]\s*\S+)?\s+(.+?)\s*$/#
			.ignoresCase()
			.anchorsMatchLineEndings()
		guard let cap = licenseText.firstMatch(of: pattern)?.output.1 else { return nil }
		let trimSet = CharacterSet(charactersIn: "*#").union(.whitespaces)
		var holder = String(cap).trimmingCharacters(in: trimSet)
		if let reserved = holder.firstRange(of: #/[.,]?\s*all rights reserved\.?$/#.ignoresCase()) {
			holder.removeSubrange(reserved)
			holder = holder.trimmingCharacters(in: trimSet)
		}
		return holder.isEmpty ? nil : holder
	}

	/// 辨識授權
	///
	/// 比對 `LICENSE` 正文的特徵語句（不依賴標題行——真實 LICENSE 標題格式不一）。
	/// 涵蓋 MIT / Apache-2.0 / BSD-2-Clause / BSD-3-Clause / ISC / MPL-2.0 /
	/// FSL-1.1（ALv2 / MIT 變體）/ GNU 家族（GPL-2.0 / GPL-3.0 / LGPL-2.1 / LGPL-3.0 /
	/// AGPL-3.0、一律 `-only`——`-or-later` 是檔頭宣告選擇、非條文差異，需要時以
	/// `--header-spdx` 覆寫）；辨識不到回 `nil`。
	public static func recognizeLicense(in licenseText: String) -> (name: String, spdxID: String)? {
		let text = licenseText.lowercased()
		if let gnu = recognizeGNUFamily(in: text) {
			return gnu
		}
		// FSL 必須先於 Apache 判斷：FSL-1.1-ALv2 的未來授權段含「Apache License, Version 2.0」
		// 字句、後置會被誤辨識為 Apache-2.0。
		if let fsl = recognizeFSL(in: text) {
			return fsl
		}
		if text.contains("apache license"), text.contains("version 2.0") {
			return ("Apache License 2.0", "Apache-2.0")
		}
		if text.contains("mozilla public license version 2.0") {
			return ("Mozilla Public License 2.0", "MPL-2.0")
		}
		if text.contains("redistribution and use in source and binary forms") {
			if text.contains("neither the name") {
				return ("BSD 3-Clause License", "BSD-3-Clause")
			}
			return ("BSD 2-Clause License", "BSD-2-Clause")
		}
		if text.contains("permission to use, copy, modify, and/or distribute") {
			return ("ISC License", "ISC")
		}
		if text.contains("permission is hereby granted, free of charge") {
			return ("MIT License", "MIT")
		}
		return nil
	}

	/// 驗證檔頭授權覆寫值是否為單一 SPDX 授權識別字
	///
	/// 接受 SPDX License List 的 idstring（字母、數字、`.`、`-`，容許 legacy 尾碼 `+`）與
	/// REUSE 規範的 `LicenseRef-<idstring>` 自訂授權；不接受含 `AND` / `OR` / `WITH` 的
	/// 複合運算式——檔頭一檔一授權、複合情境應改以 `REUSE.toml` 表達。
	public static func isValidSPDXID(_ id: String) -> Bool {
		id.wholeMatch(of: #/(?:LicenseRef-)?[A-Za-z0-9.\-]+\+?/#) != nil
	}

	/// 從 `AUTHORS` 內容抓版權持有人清單
	///
	/// 每行非空、非 `#` 註解算一筆、依檔案順序逐字 trim 後回傳。集合式（單行
	/// `The X Authors`）或逐人列名，由 `AUTHORS` 怎麼排決定、非工具強制。
	public static func authors(in authorsText: String) -> [String] {
		authorsText
			.split(separator: "\n", omittingEmptySubsequences: false)
			.map { $0.trimmingCharacters(in: .whitespaces) }
			.filter { !$0.isEmpty && !$0.hasPrefix("#") }
	}

	/// 依 target 名與來源資訊組裝檔案標頭字串
	///
	/// holder 行依授權型別分流：MPL-2.0 走 REUSE 風格、每位 `authors` 各一行
	/// `SPDX-FileCopyrightText`；其餘授權沿用 `Copyright © {created.year} <holder>`、holder
	/// 來源 Apache-2.0 取 `noticeHolder`、其餘取 `licenseHolder`；FSL-1.1 在 `licenseHolder`
	/// 缺席時 fallback 每位 `authors` 各一行 `Copyright ©`（官方模板以 we/us 指稱授權人、
	/// Notice 段的 Copyright 行可能未填）。回傳值以字面 `\n` 分隔行、供 swiftformat
	/// `--header` 使用，`{created.year}` 由 swiftformat 執行時解析。
	public static func header(
		targetName: String,
		licenseHolder: String?,
		noticeHolder: String?,
		authors: [String],
		license: LicenseInfo
	) -> String {
		var lines = ["", targetName, ""]
		switch license {
		case .missing:
			lines.append(copyrightLine(holder: nil))
			lines.append("")
		case .unrecognized:
			lines.append(copyrightLine(holder: licenseHolder))
			lines.append("See LICENSE for details.")
		case let .recognized(name, spdxID):
			if spdxID == "MPL-2.0" {
				// 無 AUTHORS 時退回 licenseHolder（REUSE 要求每檔有版權持有人）；
				// 兩者皆空由 plugin 端 hasRequiredHolder 擋下、不會到這
				let holders = authors.isEmpty ? [licenseHolder].compactMap(\.self) : authors
				for holder in holders {
					lines.append("SPDX-FileCopyrightText: {created.year} \(holder)")
				}
			} else {
				// Apache 取 NOTICE holder、缺則退回 LICENSE 解析出的 licenseHolder
				let holder = spdxID == "Apache-2.0" ? noticeHolder ?? licenseHolder : licenseHolder
				if holder == nil, spdxID.hasPrefix("FSL-1.1"), !authors.isEmpty {
					for author in authors {
						lines.append(copyrightLine(holder: author))
					}
				} else {
					lines.append(copyrightLine(holder: holder))
				}
				lines.append("Licensed under the \(name). See LICENSE for details.")
				lines.append("")
			}
			lines.append("SPDX-License-Identifier: \(spdxID)")
		}
		return lines
			.map { $0.isEmpty ? $0 : " " + $0 }
			.joined(separator: #"\n"#)
	}

	// MARK: Private

	/// 辨識 GNU 家族（GPL-2.0 / GPL-3.0 / LGPL-2.1 / LGPL-3.0 / AGPL-3.0）
	///
	/// 例外採「前綴窗標題判斷」、不用全文特徵語句：各授權正文互相引用（GPL-3.0 §13 提及
	/// AGPL、結尾建議段提及 LGPL 等）、全文比對必誤中；FSF 要求條文逐字轉載、標題塊必在
	/// 檔首，前綴窗判斷反而可靠。順序 AGPL → LGPL → GPL：後者標題是前兩者標題的子串。
	private static func recognizeGNUFamily(in lowercasedText: String) -> (name: String, spdxID: String)? {
		let head: String = .init(lowercasedText.prefix(300))
		if head.contains("gnu affero general public license") {
			return ("GNU Affero General Public License v3.0", "AGPL-3.0-only")
		}
		if head.contains("gnu lesser general public license") {
			if head.contains("version 3") {
				return ("GNU Lesser General Public License v3.0", "LGPL-3.0-only")
			}
			return ("GNU Lesser General Public License v2.1", "LGPL-2.1-only")
		}
		if head.contains("gnu general public license") {
			if head.contains("version 3") {
				return ("GNU General Public License v3.0", "GPL-3.0-only")
			}
			return ("GNU General Public License v2.0", "GPL-2.0-only")
		}
		return nil
	}

	/// 辨識 FSL-1.1 兩變體
	///
	/// 變體靠「mit license」詞組分流（ALv2 變體全文無此詞組；不可用裸 "mit"——會誤中
	/// "Permitted"）。
	private static func recognizeFSL(in lowercasedText: String) -> (name: String, spdxID: String)? {
		guard lowercasedText.contains("functional source license") else { return nil }
		if lowercasedText.contains("mit license") {
			return ("Functional Source License 1.1", "FSL-1.1-MIT")
		}
		return ("Functional Source License 1.1", "FSL-1.1-ALv2")
	}

	/// 組版權行——有持有人則附上、否則只到年份
	private static func copyrightLine(holder: String?) -> String {
		if let holder {
			"Copyright © {created.year} \(holder)"
		} else {
			"Copyright © {created.year}"
		}
	}
}

// REUSE-IgnoreEnd
