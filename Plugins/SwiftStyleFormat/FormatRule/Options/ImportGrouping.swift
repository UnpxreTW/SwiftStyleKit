//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/sortImports(rule:mode:)`` 對 import 語句的排序策略
	///
	/// 對應 swiftformat 的 `importgrouping` option。分組內各自字母排序。
	public enum ImportGrouping: String, FormatRuleOption {

		/// 純字母排序、不分組（swiftformat 上游預設）
		case alpha

		/// 按 import 字串長度排序
		case length

		/// `@testable` import 集中排前面、各組內部字母排序（簽名預設）
		case testableFirst = "testable-first"

		/// `@testable` import 集中排後面、各組內部字母排序
		case testableLast = "testable-last"

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "importgrouping"
	}
}
