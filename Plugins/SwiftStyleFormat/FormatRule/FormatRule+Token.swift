//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// 規則啟用 token——dispatch 到可帶 option 的 `.on` overload
	public enum OnToken {

		/// 啟用（`on` 為刻意的 2 字元開關名、短於 identifier_name 下限）
		case on // swiftlint:disable:this identifier_name
	}

	/// 規則停用 token——dispatch 到不可帶 option 的 `.off` overload
	public enum OffToken {

		/// 停用
		case off
	}
}
