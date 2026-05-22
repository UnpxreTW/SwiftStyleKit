//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	// swiftlint:disable:next line_length
	/// ``FormatRule/wrapArguments(rule:wrapArguments:wrapParameters:wrapCollections:wrapConditions:wrapTypeAliases:wrapEffects:wrapReturnType:closingParen:callSiteParen:allowPartialWrapping:)``
	/// 對 closing paren `)` 擺位的模式
	///
	/// 對應 swiftformat 的 `closing-paren` 與 `call-site-paren` 兩個 option，
	/// 本 enum 被兩者共用、故不 conform ``FormatRuleOption``。
	public enum ParenPlacement: String {

		/// `)` 與 `{` 之間留空白、視覺對稱（swiftformat `closing-paren` 上游預設）
		case balanced

		/// `)` 緊貼下一行開頭（同一行）
		case sameLine = "same-line"
	}
}
