//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/void(rule:mode:)`` 的 type 位置 `Void` 表示法
	///
	/// 對應 swiftformat 的 `void-type` option。swiftformat 內部為 Bool keyPath
	/// 但 CLI 字面值只接受 `Void` / `tuple` 等字面、不接受 `true`/`false`，
	/// 因此不能用通用 ``Toggle`` 而需專屬 enum。
	public enum VoidType: String, FormatRuleOption {

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "voidType"

		/// type 位置用 `Void`（swiftformat 上游預設、Swift 社群標準）
		case void = "Void"

		/// type 位置用 `()`
		case tuple
	}
}
