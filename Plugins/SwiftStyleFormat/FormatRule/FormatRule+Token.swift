//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

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
