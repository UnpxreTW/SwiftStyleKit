//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/typeSugar(rule:mode:)`` 的 `Optional<T>` → `T?` 轉換邊角模式
	///
	/// 對應 swiftformat 的 `short-optionals` option；僅控 Optional sugar 的精細度，
	/// `Array<T>` / `Dictionary<K, V>` sugar 無例外、永遠轉。
	public enum OptionalsMode: String, FormatRuleOption {

		/// 保留 struct stored property 位置的 `Optional<T>`（swiftformat 上游預設）
		///
		/// 該位置寫 `Optional<T>` 時 Swift 編譯器生成 `init(prop: Optional<T>)`、
		/// 強迫呼叫端明確傳 `nil`；改為 `T?` 後編譯器生成 `init(prop: T? = nil)`、
		/// 呼叫端可省略——此模式保護「故意用長形式維持 API contract」的寫法。
		/// 其他位置（function signature / local var / global var）仍轉 sugar。
		case preserveStructInits = "preserve-struct-inits"

		/// `Optional<T>` 永遠轉 `T?`、不管 struct memberwise init 副作用
		case always

		/// **deprecated**——swiftformat 已不建議使用、不應選此值
		case exceptPropertiesDeprecated = "except-properties"

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "shortOptionals"
	}
}
