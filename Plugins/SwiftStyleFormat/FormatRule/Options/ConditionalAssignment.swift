//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// `conditionalAssignment` 規則的套用範圍
	///
	/// 對應 swiftformat 的 `conditional-assignment` option。
	public enum ConditionalAssignmentMode: String, FormatRuleOption {

		/// 只在新屬性宣告（`let foo: Type`）後套用（swiftformat 上游預設）
		case afterProperty = "after-property"

		/// 對所有可賦值的 lvalue 都套用（既有變數 / 成員存取 / 下標）
		case always

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "conditionalAssignment"
	}
}
