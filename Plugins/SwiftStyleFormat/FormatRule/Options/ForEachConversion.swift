//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/preferForLoop(rule:anonymousForEach:singleLineForEach:)`` 的轉換時機
	///
	/// 對應 swiftformat 的 `anonymous-for-each` 與 `single-line-for-each` option。
	public enum ForEachConversion: String {

		/// 保留此種 forEach、不轉成 for-loop（swiftformat trueValue：`ignore` / `preserve`）
		case ignore

		/// 轉成 for-loop（swiftformat falseValue）
		case convert
	}
}
