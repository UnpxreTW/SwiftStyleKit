//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	// swiftlint:disable:next line_length
	/// ``FormatRule/wrapArguments(rule:wrapArguments:wrapParameters:wrapCollections:wrapConditions:wrapTypeAliases:wrapEffects:wrapReturnType:closingParen:callSiteParen:allowPartialWrapping:)``
	/// 對 multi-line 列表（function arguments / parameters / collections / conditions / typealiases）的換行模式
	///
	/// 對應 swiftformat 的 `wrap-arguments` / `wrap-parameters` / `wrap-collections` /
	/// `wrap-conditions` / `wrap-type-aliases` 五個 option，本 enum 被五者共用、
	/// 故不 conform ``FormatRuleOption``、由各 case 簽名的參數 label 決定 CLI flag 名。
	public enum WrapMode: String {

		/// 第一個元素換到下一行、整個列表展開多行
		case beforeFirst = "before-first"

		/// 第一個元素留在開括號後、後續元素換到下一行對齊第一個
		case afterFirst = "after-first"

		/// 保留既有寫法、不強制換行模式（swiftformat 上游預設）
		case preserve

		/// 完全 disable 列表內換行
		case disabled
	}
}
