//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/propertyTypes(rule:propertyTypes:inferredTypes:preservedPropertyTypes:)``
	/// 的 inferred types 適用範圍模式
	///
	/// 對應 swiftformat 的 `inferred-types` option。swiftformat 內部為 Bool keyPath
	/// 但 CLI 字面值只接 `exclude-cond-exprs` / `always`、不接 `true`/`false`，
	/// 因此不能用通用 ``Toggle`` 而需專屬 enum（同 ``TrimWhitespace`` / ``VoidType`` 套路）。
	///
	/// 只在 ``FormatRule/PropertyTypes/inferred`` 模式下生效；對
	/// ``FormatRule/PropertyTypes/explicit``（SwiftStyleKit 簽名預設）無作用、
	/// 純為 fork 簽名 hint 暴露。
	public enum InferredTypesMode: String, FormatRuleOption {

		/// 條件表達式（`if let foo: Foo` 等）內保留顯式型別、其他位置用推導
		case excludeCondExprs = "exclude-cond-exprs"

		/// 所有位置都用推導（swiftformat 上游預設、SwiftStyleKit 簽名預設）
		case always

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "inferredTypes"
	}
}
