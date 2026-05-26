//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// `blankLineAfterSwitchCase` 規則的空白行插入模式
	///
	/// - note: rule 為 `.disable` 時此參數會被忽略（reflection chain 對 disable
	///   提前 break、不展開 mode）
	public enum BlankLineAfterSwitchCaseMode: String, FormatRuleOption {

		/// 只在 multi-line case 後插空白行（swiftformat 上游預設行為）
		case multilineOnly = "multiline-only"

		/// 在每個 case 後都插空白行
		case always

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "blankLineAfterSwitchCase"

	}
}
