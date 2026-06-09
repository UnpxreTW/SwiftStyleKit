//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/markTypes(rule:markTypes:typeMark:markExtensions:extensionMark:groupedExtension:)``
	/// 的型別 / extension 標記時機
	///
	/// 對應 swiftformat 的 `mark-types` 與 `mark-extensions` option。
	public enum MarkMode: String {

		/// 一律標記
		case always

		/// 一律不標記
		case never

		/// 只標記非空的宣告
		case ifNotEmpty = "if-not-empty"
	}
}
