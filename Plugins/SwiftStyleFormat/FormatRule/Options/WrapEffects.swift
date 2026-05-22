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
	/// 對 function effects（`throws` / `async`）與 return type 的換行條件
	///
	/// 對應 swiftformat 的 `wrap-effects` 與 `wrap-return-type` 兩個 option，
	/// 本 enum 被兩者共用、故不 conform ``FormatRuleOption``。
	public enum WrapEffects: String {

		/// 保留既有寫法（swiftformat 上游預設）
		case preserve

		/// 只在 function 已 multi-line 時才換行
		case ifMultiline = "if-multiline"

		/// 永遠不換行
		case never
	}
}
