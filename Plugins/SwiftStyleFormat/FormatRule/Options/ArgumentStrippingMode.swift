//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/unusedArguments(rule:mode:)`` 的未使用 argument 標 `_` 範圍模式
	///
	/// 對應 swiftformat 的 `strip-unused-args` option。
	public enum ArgumentStrippingMode: String, FormatRuleOption {

		/// 只動 `func foo(_ bar: Int)` 這種已 underscore label 的 args；其他位置不動
		case unnamedOnly = "unnamed-only"

		/// 只動 closure 內未使用的 args；function declaration 不動（適合
		/// 「function signature 是 API contract」的場景、保留 `func foo(bar: Int)`
		/// 即使內部沒用 `bar` 也不改寫）
		case closureOnly = "closure-only"

		/// function declaration + closure 都動（swiftformat 上游預設）
		case all = "always"

		/// 對應的 swiftformat CLI option flag 名稱
		///
		/// swiftformat argument name 為 kebab-case `strip-unused-args`（**不是**
		/// keyPath 名 `stripUnusedArguments`）；camelCase 等價形式為 `stripUnusedArgs`、
		/// swiftformat 接受。
		public static let flagName = "stripUnusedArgs"
	}
}
