//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/typeBlankLines(mode:)`` 全域 option 的值型別——type 宣告邊界
	/// 空白行的處理方式
	///
	/// 對應 swiftformat 的 `type-blank-lines` option。
	public enum TypeBlankLines: String, FormatRuleOption {

		/// 移除 type 宣告邊界的空白行（swiftformat 上游預設）
		case remove

		/// 在 type 宣告邊界插入空白行
		case insert

		/// 保留 type 宣告邊界既有的空白行
		case preserve

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "typeBlankLines"
	}
}
