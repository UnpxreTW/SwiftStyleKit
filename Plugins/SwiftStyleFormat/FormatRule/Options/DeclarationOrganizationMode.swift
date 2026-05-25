//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/organizeDeclarations`` 的整體組織模式
	///
	/// 對應 swiftformat 的 `organization-mode` option。決定 `visibility-order` 跟
	/// `type-order` 的預設值與 organize 主軸。
	public enum DeclarationOrganizationMode: String, FormatRuleOption {

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "organizationMode"

		/// 依 visibility 為主軸組織（swiftformat 上游預設）
		case visibility

		/// 依 declaration type 為主軸組織
		case type
	}
}
