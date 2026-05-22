//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/trailingCommas(rule:mode:)`` 的多行列表 trailing comma 處理模式
	///
	/// 對應 swiftformat 的 `trailing-commas` option。
	public enum TrailingCommas: String, FormatRuleOption {

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "trailingCommas"

		/// 移除所有 trailing comma
		case never

		/// 所有 multi-line 列表都加 trailing comma（swiftformat 上游預設、Swift 6.1+
		/// 起 function args/params/generic params 亦支援）
		case always

		/// 只在 collection literal `[]` 內加 trailing comma、function call/decl/
		/// generic params 不動。對齊預設啟用 swiftlint `trailing_comma` 規則的 fork
		case collectionsOnly = "collections-only"

		/// multi-element 列表才加 trailing comma；單元素列表豁免、不加
		case multiElementLists = "multi-element-lists"
	}
}
