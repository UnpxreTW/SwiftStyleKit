//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/swiftTestingTestCaseNames(rule:testCaseNameFormat:suiteNameFormat:)``
	/// 對 Swift Testing `@Test` / `@Suite` 名稱的格式化模式
	///
	/// 對應 swiftformat 的 `test-case-name-format` 與 `suite-name-format` 兩個 option。本 enum
	/// 被兩個 option 共用、故不 conform ``FormatRuleOption``、由 case 簽名的參數
	/// label（`testCaseNameFormat:` / `suiteNameFormat:`）決定 CLI flag 名。
	public enum SwiftTestingNameFormat: String {

		/// 保留既有寫法、不動
		case preserve

		/// raw identifier 模式：把 `@Test("…")` / `@Suite("…")` 描述字串提升到 function / type
		/// 名本體（轉成 backtick 包覆的 raw identifier）、移除 macro 的描述參數。
		/// Swift 6.2+ raw identifier 語法、規則對低版本自動 no-op
		case rawIdentifiers = "raw-identifiers"

		/// standard identifier 模式：對既有 raw identifier 反向轉成 camelCase 標準 identifier、
		/// 移除 macro 描述參數
		case standardIdentifiers = "standard-identifiers"
	}
}
