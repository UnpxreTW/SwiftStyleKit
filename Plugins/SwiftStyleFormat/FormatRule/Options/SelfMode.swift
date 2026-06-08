//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/redundantSelf(rule:mode:selfRequired:)`` 對顯式 `self.` 的處理策略
	///
	/// 對應 swiftformat 的 `self` option。
	public enum SelfMode: String, FormatRuleOption {

		/// 移除所有可省略的 `self.`（swiftformat 上游預設、minimal 派）
		case remove

		/// 強制所有 instance member 加 `self.`（explicit 派）
		case insert

		/// 只在 `init` 內強制 `self.`、其他位置移除（折衷派）
		case initOnly = "init-only"

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "self"
	}
}
