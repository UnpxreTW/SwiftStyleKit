//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/wrap(rule:maxWidth:noWrapOperators:assetLiterals:wrapTernary:wrapStringInterpolation:)``
	/// 對 Xcode asset literal token（`#colorLiteral` / `#imageLiteral`）的字寬計算模式
	///
	/// 對應 swiftformat 的 `asset-literals` option。
	public enum AssetLiteralWidth: String, FormatRuleOption {

		/// 按 source code 實際字數計算寬度（不在 Xcode 內編輯 source 時更貼近實際 line width）
		case actualWidth = "actual-width"

		/// 按 Xcode IDE 內 inline 色塊 / 圖示顯示寬度計算（swiftformat 上游預設）
		case visualWidth = "visual-width"

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "assetLiterals"
	}
}
