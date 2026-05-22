//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/trailingSpace(rule:mode:)`` 的尾空白清理模式
	///
	/// 對應 swiftformat 的 `trim-whitespace` option。swiftformat 內部為 Bool keyPath
	/// 但 CLI 字面值只接受 `always` / `nonblank-lines`、不接受 `true`/`false`，
	/// 因此不能用通用 ``Toggle`` 而需專屬 enum。
	public enum TrimWhitespace: String, FormatRuleOption {

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "trimWhitespace"

		/// 清行尾空白 + 清純空白行的縮排（swiftformat 上游預設）
		case always

		/// 只清非空白行的尾空白、保留純空白行的縮排（適合「按 Enter 後光標
		/// 自動縮排」的編輯器體驗、避免每次儲存後 git diff 顯示「空白行縮排被刪」）
		case nonblankLines = "nonblank-lines"
	}
}
