//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// 規則啟用 token——dispatch 到 enable overload（可帶 option）
	///
	/// `EnableToken` / `DisableToken` 是只承載 `.enable` / `.disable` 單一 case 的型別。
	/// 型別安全 overload 用 `rule:` 參數型別（`EnableToken` vs `DisableToken`）區分 enable /
	/// disable 路徑——call site 維持 `.enable` / `.disable` 寫法、由 Swift 依 overload 期望
	/// 型別解析。`rule: .disable` 時帶 option 會命中 `@available(*, unavailable)` 毒餌
	/// overload、編譯期報「mode 只在 .enable 有效」。
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
