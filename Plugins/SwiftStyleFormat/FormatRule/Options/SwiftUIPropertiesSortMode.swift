//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/organizeDeclarations`` 對 SwiftUI property（`@State` / `@Binding` 等）的排序模式
	///
	/// 對應 swiftformat 的 `sort-swiftui-properties` option。
	public enum SwiftUIPropertiesSortMode: String, FormatRuleOption {

		/// 不排序（swiftformat 上游預設）
		case none

		/// 字母順序排
		case alphabetize

		/// 依「首次出現順序」group 同型別 property
		case firstAppearanceSort = "first-appearance-sort"

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "sortSwiftUIProperties"
	}
}
