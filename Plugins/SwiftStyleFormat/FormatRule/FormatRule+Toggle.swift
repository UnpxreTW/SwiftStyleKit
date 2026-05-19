//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// 規則專屬布林 option 的開關
	///
	/// 對應 swiftformat 接受 `"true"` / `"false"` 的 option。與控制整條規則啟用與否
	/// 的 ``Flag`` 平行——`Flag` 的 rawValue 是 `enable` / `disable`，布林 option 需要
	/// `true` / `false`，故另立此型別。reflection chain 透過 `RawRepresentable<String>`
	/// 分支取 rawValue 展開。
	public enum Toggle: String {

		/// option 開啟（CLI 值 `true`）
		case enable = "true"

		/// option 關閉（CLI 值 `false`）
		case disable = "false"
	}
}
