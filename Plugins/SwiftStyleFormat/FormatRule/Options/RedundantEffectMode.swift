//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/redundantAsync(rule:redundantAsync:)`` 與 ``FormatRule/redundantThrows(rule:redundantThrows:)``
	/// 移除冗餘 effect 修飾詞（`async` / `throws`）的範圍模式
	///
	/// 對應 swiftformat 的 `redundant-async` 與 `redundant-throws` 兩個 option。本 enum
	/// 被兩個獨立規則 own、故不 conform ``FormatRuleOption``、由各 case 簽名的參數
	/// label（與 case 名同名）決定 CLI flag 名。
	public enum RedundantEffectMode: String {

		/// 只移除測試函式（`@Test` / `XCTestCase`）內的多餘 effect 修飾詞（swiftformat 上游預設）
		case testsOnly = "tests-only"

		/// 所有函式都移除多餘 effect 修飾詞（可能讓既有 call site 的 `await`/`try` 變 warning）
		case always
	}
}
