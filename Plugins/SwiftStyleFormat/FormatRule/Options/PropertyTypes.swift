//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/propertyTypes(rule:propertyTypes:inferredTypes:preservedPropertyTypes:)``
	/// 的 property 型別顯式 / 推導模式
	///
	/// 對應 swiftformat 的 `property-types` option。
	public enum PropertyTypes: String, FormatRuleOption {

		/// 所有 property 都用顯式型別（SwiftStyleKit 簽名預設）
		///
		/// `let foo = Foo()` → `let foo: Foo = .init()`、跟 `redundantType .explicit` 同調
		case explicit

		/// 所有 property 都用推導
		///
		/// `let foo: Foo = .init()` → `let foo = Foo()`
		case inferred

		/// 對 local scope（method body 等）用 `.inferred`、對 global / type property
		/// 用 `.explicit`（swiftformat 上游預設、type checking 對 global 較吃力）
		case inferLocalsOnly = "infer-locals-only"

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "propertyTypes"
	}
}
