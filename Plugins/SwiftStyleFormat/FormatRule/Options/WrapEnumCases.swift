//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/wrapEnumCases(rule:wrapEnumCases:)`` 的拆行模式
	///
	/// 對應 swiftformat 的 `wrap-enum-cases` option。
	public enum WrapEnumCases: String, FormatRuleOption {

		/// 所有逗號分隔 case 都拆成一行一個（上游預設、SwiftStyleKit 簽名預設）
		case always

		/// 只拆有 associated value 的 case、簡單 case（無 associated value）保留單行
		case withValues = "with-values"

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "wrapEnumCases"
	}
}
