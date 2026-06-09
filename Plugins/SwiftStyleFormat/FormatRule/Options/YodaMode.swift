//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/yodaConditions(rule:mode:)`` 的 yoda condition 處理範圍模式
	///
	/// 對應 swiftformat 的 `yoda-swap` option。
	public enum YodaMode: String, FormatRuleOption {

		/// 只翻字面值放左側的情形（如 `5 == foo` → `foo == 5`）
		case literalsOnly = "literals-only"

		/// 所有 yoda condition 都翻（含 `.default == baaz` 等非字面值常數、swiftformat 上游預設）
		case always

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "yodaSwap"
	}
}
