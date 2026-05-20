//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/redundantNilInit(rule:mode:)`` 對 Optional `var` 預設 `nil` 的處理
	///
	/// 對應 swiftformat 的 `nilinit` option。
	public enum NilInitMode: String, FormatRuleOption {

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "nilinit"

		/// 移除 Optional `var` 多餘的 `= nil`（swiftformat 上游預設）
		case remove

		/// 為 Optional `var` 插入 `= nil` 預設值
		case insert
	}
}
