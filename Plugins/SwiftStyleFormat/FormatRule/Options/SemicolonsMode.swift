//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/semicolons(rule:mode:)`` 對分號的容忍度
	///
	/// 對應 swiftformat 的 `semicolons` option。兩種值下行尾分號 `let x = 5;` 都會被移除；
	/// 差別在同行兩 statement（`let x = 5; let y = 6`）的處理。
	public enum SemicolonsMode: String, FormatRuleOption {

		/// 不允許任何分號、同行兩 statement 拆成兩行
		case never

		/// 允許 inline 分號（同行隔離 statement、swiftformat 上游預設）
		case inline

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "semicolons"

	}
}
