//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	// swiftlint:disable:next line_length
	/// ``FormatRule/wrapAttributes(rule:funcAttributes:typeAttributes:varAttributes:storedVarAttributes:computedVarAttributes:complexAttributes:nonComplexAttributes:)``
	/// 對 `@attribute` 擺位的模式
	///
	/// 對應 swiftformat 的 6 個 `*-attributes` option：`func-attributes` / `type-attributes` /
	/// `var-attributes` / `stored-var-attributes` / `computed-var-attributes` / `complex-attributes`，
	/// 本 enum 被六者共用、不 conform ``FormatRuleOption``、由各 case 簽名的參數 label 決定 CLI flag 名。
	public enum AttributeMode: String {

		/// `@attribute` 換到上一行、宣告自成一行（強調 attribute 存在感、SwiftUI / Concurrency 慣例）
		case prevLine = "prev-line"

		/// `@attribute` 與宣告同行
		case sameLine = "same-line"

		/// 保留既有寫法、不強制（swiftformat 上游預設）
		case preserve
	}
}
