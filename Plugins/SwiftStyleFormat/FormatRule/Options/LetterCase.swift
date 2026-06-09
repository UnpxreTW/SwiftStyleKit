//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	// DocC 參數化符號連結無法換行、單行豁免 line_length
	// swiftlint:disable:next line_length
	/// ``FormatRule/numberFormatting(rule:decimalGrouping:binaryGrouping:octalGrouping:hexGrouping:fractionGrouping:exponentGrouping:hexLiteralCase:exponentCase:)``
	/// 的 hex 字母與指數 `e` 大小寫
	///
	/// 對應 swiftformat 的 `hex-literal-case` 與 `exponent-case` option。
	public enum LetterCase: String {

		/// 大寫
		case uppercase

		/// 小寫
		case lowercase
	}
}
