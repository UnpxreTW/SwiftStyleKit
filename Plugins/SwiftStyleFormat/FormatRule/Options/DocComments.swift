//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/docComments(rule:mode:)`` 規則的 doc comment 正規化範圍
	///
	/// 對應 swiftformat 的 `doc-comments` option。
	public enum DocCommentsMode: String, FormatRuleOption {

		/// 雙向正規化：宣告上的 `//` 升 `///`、非宣告處的 `///` 降 `//`（swiftformat 上游預設）
		case beforeDeclarations = "before-declarations"

		/// 只升級 `//` → `///`，不動既有 `///`
		case preserve

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "docComments"

	}
}
