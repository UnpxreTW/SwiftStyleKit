//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/redundantVoidReturnType(rule:closureVoid:)`` 對 closure literal `() -> Void in` 的處理
	///
	/// 對應 swiftformat 的 `closurevoid` option。只影響 closure expression（後接 `in`）；
	/// typealias 與函式型別宣告（`var cb: () -> Void`）兩種值都不會動。
	public enum ClosureVoidReturn: String, FormatRuleOption {

		/// closure 內的 `-> Void` 一律移除（`{ () -> Void in ... }` → `{ () in ... }`、swiftformat 上游預設）
		case remove

		/// closure 內顯式寫的 `-> Void` 保留
		case preserve

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "closurevoid"
	}
}
