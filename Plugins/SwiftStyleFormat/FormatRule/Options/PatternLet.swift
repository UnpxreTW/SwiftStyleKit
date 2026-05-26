//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/hoistPatternLet(rule:mode:)`` 的 `let` / `var` binding 擺位
	///
	/// 對應 swiftformat 的 `pattern-let` option。
	public enum PatternLet: String, FormatRuleOption {

		/// `let` 一次提到 pattern 最前——`if case let .foo(a, b)`（swiftformat 上游預設）
		case hoist

		/// 每個 binding 各自帶 `let`——`if case .foo(let a, let b)`
		case inline

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "patternLet"
	}
}
