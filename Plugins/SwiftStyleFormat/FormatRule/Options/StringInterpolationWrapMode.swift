//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/wrap(rule:maxWidth:noWrapOperators:assetLiterals:wrapTernary:wrapStringInterpolation:)``
	/// 對字串 `\(...)` 內插值的換行模式
	///
	/// 對應 swiftformat 的 `wrap-string-interpolation` option。本 option 同時被 `wrap` 與
	/// `wrapArguments` 兩規則 own，未來 `wrapArguments` 加入後可能依「全域 option 慣例」
	/// 抽出至列舉底部獨立 case。
	public enum StringInterpolationWrapMode: String, FormatRuleOption {

		/// 需要時可在 `\(...)` 內 / 周圍斷行（swiftformat 上游預設）
		case `default`

		/// 保留字串原樣、即使超過 max-width 也不動內插值
		case preserve

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "wrapStringInterpolation"

	}
}
