//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/redundantType(rule:mode:)`` 對冗餘型別標註的處理策略
	///
	/// 對應 swiftformat 的 `redundantType` option。
	public enum RedundantTypeMode: String, FormatRuleOption {

		/// 移除型別標註、保留右側型別前綴（minimal 派）
		///
		/// `let view: UIView = UIView()` → `let view = UIView()`
		case inferred

		/// 保留型別標註、把右側 `Type(...)` 改成 `.init(...)`（strong-typing 派）
		///
		/// `let view: UIView = UIView()` → `let view: UIView = .init()`
		case explicit

		/// 頂層 stored property 走 `explicit`、function 內 local 走 `inferred`（swiftformat 上游預設、折衷派）
		case inferLocalsOnly = "infer-locals-only"

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "redundantType"

	}
}
