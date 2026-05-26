//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/wrap(rule:maxWidth:noWrapOperators:assetLiterals:wrapTernary:wrapStringInterpolation:)``
	/// 對多行三元運算式 `a ? b : c` 的換行模式
	///
	/// 對應 swiftformat 的 `wrap-ternary` option。
	public enum TernaryOperatorWrapMode: String, FormatRuleOption {

		/// `?` / `:` 放下一行開頭（swiftformat 上游預設、Swift 社群主流寫法）
		case `default`

		/// `?` / `:` 留在上一行結尾、下一行只放值
		case beforeOperators = "before-operators"

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "wrapTernary"

	}
}
