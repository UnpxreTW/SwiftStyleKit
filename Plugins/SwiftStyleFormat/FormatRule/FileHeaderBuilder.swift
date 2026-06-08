//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import Foundation

/// 檔案標頭組裝
///
/// 由 plugin 在執行期呼叫——`copyrightHolder` 與 `recognizeLicense` 解析使用端專案的
/// `LICENSE`，`header` 依結果組出傳給 swiftformat `--header` 的標頭字串。
public enum FileHeaderBuilder {

	/// `LICENSE` 檔的辨識結果（僅授權類型；版權持有人改由 AUTHORS / 設定提供、與授權正交）
	public enum LicenseInfo {

		/// 無 `LICENSE` 檔
		case missing

		/// 有 `LICENSE` 檔、但授權類型未辨識
		case unrecognized

		/// 有 `LICENSE` 檔、授權類型已辨識
		case recognized(name: String, spdxID: String)
	}

	/// 從 `LICENSE` 內容抓版權持有人
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
	/// 涵蓋 MIT / Apache-2.0 / BSD-2-Clause / BSD-3-Clause / ISC / MPL-2.0；辨識不到回 `nil`。
	public static func recognizeLicense(in licenseText: String) -> (name: String, spdxID: String)? {
		let text = licenseText.lowercased()
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

	/// 依 target 名、版權持有人清單與 `LICENSE` 辨識結果組裝標頭字串（SPDX / REUSE 風格）
	///
	/// 每個 holder 產一行 `SPDX-FileCopyrightText`（依序、0..n 筆、無則省略）；授權以
	/// `SPDX-License-Identifier` 表示。回傳值以字面 `\n` 分隔行、供 swiftformat `--header`
	/// 使用，`{created.year}` 維持 token 形式、由 swiftformat 執行時解析。
	public static func header(targetName: String, holders: [String], license: LicenseInfo) -> String {
		var lines = ["", targetName, ""]
		for holder in holders {
			lines.append("SPDX-FileCopyrightText: {created.year} \(holder)")
		}
		switch license {
		case .missing:
			break
		case .unrecognized:
			lines.append("See LICENSE for details.")
		case let .recognized(_, spdxID):
			lines.append("SPDX-License-Identifier: \(spdxID)")
		}
		return lines
			.map { $0.isEmpty ? $0 : " " + $0 }
			.joined(separator: #"\n"#)
	}
}
