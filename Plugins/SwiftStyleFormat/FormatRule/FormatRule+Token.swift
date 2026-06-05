//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	// EnableToken / DisableToken 各只承載 .enable / .disable 一個 case，給型別安全 overload
	// 做 dispatch：`rule:` 參數型別（EnableToken vs DisableToken）區分 enable / disable，
	// call site 維持 .enable / .disable 寫法、由 Swift 依 overload 期望型別解析。.disable
	// 誤帶 option 會命中 `@available(*, unavailable)` 診斷 overload、編譯期報「option 只在
	// .enable 有效」。

	/// 規則啟用 token——dispatch 到 enable overload（可帶 option）
	public enum EnableToken {

		/// 規則啟用
		case enable
	}

	/// 規則停用 token——dispatch 到 disable overload（不可帶 option）
	public enum DisableToken {

		/// 規則停用
		case disable
	}
}
