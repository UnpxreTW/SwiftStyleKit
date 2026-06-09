//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/organizeDeclarations`` 對 type body 內既有 `MARK:` 註解的處理模式
	///
	/// 對應 swiftformat 的 `type-body-marks` option。
	public enum TypeBodyMarks: String, FormatRuleOption {

		/// 保留所有既有 MARK 註解（swiftformat 上游預設）
		case preserve

		/// 移除不符合預期 visibility / declaration kind 的 MARK 註解
		case remove

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "typeBodyMarks"
	}
}
