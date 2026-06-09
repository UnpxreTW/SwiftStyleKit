//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/indent(rule:indent:tabWidth:smartTabs:indentCase:ifdef:xcodeIndentation:indentStrings:)``
	/// 的 `#if` 區塊縮排方式
	///
	/// 對應 swiftformat 的 `ifdef` option。
	public enum IfdefIndent: String, FormatRuleOption {

		/// `#if` 內容比 `#if` 多縮一層（swiftformat 上游預設）
		case indent

		/// `#if` 內容與 `#if` 同層
		case noIndent = "no-indent"

		/// 保留原樣不動
		case preserve

		/// `#if` / `#endif` 指令本身推到行首
		case outdent

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "ifdef"
	}
}
