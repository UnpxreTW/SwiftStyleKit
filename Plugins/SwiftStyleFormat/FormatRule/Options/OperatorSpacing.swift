//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/spaceAroundOperators(rule:operatorFunc:ranges:typeDelimiter:noSpaceOperators:)``
	/// 對 operator 周圍空白的處理模式
	///
	/// 對應 swiftformat 的 `operator-func` 與 `ranges` 兩個 option。本 enum
	/// 被兩個 option 共用、故不 conform ``FormatRuleOption``、由 case 簽名的
	/// 參數 label（`operatorFunc:` / `ranges:`）決定 CLI flag 名。
	public enum OperatorSpacing: String {

		/// 插入空白：`func == (` / `a ..< b`
		case insert = "spaced"

		/// 移除空白：`func ==(` / `a..<b`
		case remove = "no-space"

		/// 保留既有寫法、不強制
		case preserve
	}
}
