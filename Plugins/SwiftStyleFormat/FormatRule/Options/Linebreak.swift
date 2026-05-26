//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/linebreaks(rule:mode:)`` 使用的換行字元
	///
	/// 對應 swiftformat 的 `linebreaks` option。
	public enum Linebreak: String, FormatRuleOption {

		// cr / crlf / lf 是換行字元的標準縮寫、較全名通用

		/// `\r`——舊 Mac 換行
		// swiftlint:disable:next identifier_name
		case cr

		/// `\r\n`——Windows 換行
		case crlf

		/// `\n`——Unix 換行（swiftformat 上游預設）
		// swiftlint:disable:next identifier_name
		case lf

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "linebreaks"
	}
}
