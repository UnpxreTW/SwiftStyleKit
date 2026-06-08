//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/emptyBraces(rule:mode:)`` 對空大括號的處理方式
	///
	/// 對應 swiftformat 的 `empty-braces` option。
	public enum EmptyBracesSpacing: String, FormatRuleOption {

		/// `{}`——大括號間不留空白（swiftformat 上游預設）
		case noSpace = "no-space"

		/// `{ }`——大括號間留一個空格
		case spaced

		/// `{` 換行 `}`——空 body 但維持兩行
		case linebreak

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "emptyBraces"
	}
}
