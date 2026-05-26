//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/extensionAccessControl(rule:mode:)`` 的存取控制修飾詞擺位
	///
	/// 對應 swiftformat 的 `extension-acl` option。
	public enum ExtensionACLPlacement: String, FormatRuleOption {

		/// 修飾詞放在 `extension` 關鍵字上、成員不寫（swiftformat 上游預設）
		case onExtension = "on-extension"

		/// `extension` 不寫、修飾詞下放到每個成員
		case onDeclarations = "on-declarations"

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "extensionAcl"
	}
}
