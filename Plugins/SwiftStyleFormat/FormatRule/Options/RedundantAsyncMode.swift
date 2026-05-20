//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/redundantAsync(rule:mode:)`` 的移除範圍
	///
	/// 對應 swiftformat 的 `redundant-async` option。
	public enum RedundantAsyncMode: String, FormatRuleOption {

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "redundantAsync"

		/// 只移除測試函式（`@Test` / `XCTestCase`）的多餘 `async`（swiftformat 上游預設）
		case testsOnly = "tests-only"

		/// 所有函式都移除多餘 `async`（可能讓既有 call site 的 `await` 變 warning）
		case always
	}
}
