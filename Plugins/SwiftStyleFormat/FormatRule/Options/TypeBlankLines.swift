//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
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

		/// 由 swiftformat 自行判定 type 宣告邊界空白行的一致性（上游 0.62.0 起新增）
		///
		/// SwiftStyleKit 未採用此值；以 0.62.1 實測的小型樣本中其表現與 ``preserve``
		/// 無異、未能分辨兩者差異，故此處不敘述其判定規則、僅保留可選值。
		case consistent

		/// 只在 type 宣告開頭插入空白行、結尾的一律移除
		///
		/// CLI 字面值為 kebab-case `start-only`——swiftformat 不接受 camelCase 值。
		case startOnly = "start-only"

		/// 只在 type 宣告結尾插入空白行、開頭的一律移除
		///
		/// CLI 字面值為 kebab-case `end-only`——swiftformat 不接受 camelCase 值。
		case endOnly = "end-only"

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "typeBlankLines"
	}
}
