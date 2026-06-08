//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/spaceAroundOperators(rule:operatorFunc:ranges:typeDelimiter:noSpaceOperators:)``
	/// 對型別冒號 `: Type` 周圍空白的處理模式
	///
	/// 對應 swiftformat 的 `type-delimiter` option。為與 ``OperatorSpacing``
	/// 慣例一致（兩者同屬一條規則的 option 群），不 conform ``FormatRuleOption``、
	/// 由 case 簽名的 `typeDelimiter:` label 決定 CLI flag 名。
	public enum DelimiterSpacing: String {

		/// 冒號前後都加空白：`foo : Int`
		case spaced

		/// 冒號前不空、後空（Swift 標準）：`foo: Int`
		case spaceAfter = "space-after"

		/// 冒號前後都不空：`foo:Int`
		case noSpace = "no-space"
	}
}
