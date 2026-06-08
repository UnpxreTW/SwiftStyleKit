//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/indent(rule:indent:tabWidth:smartTabs:indentCase:ifdef:xcodeIndentation:indentStrings:)``
	/// 的縮排單位
	///
	/// 對應 swiftformat 的 `indent` option。swiftformat 上游預設為 4 空格。
	public enum Indentation: RawRepresentable, FormatRuleOption {

		/// 以 N 個空格縮排
		case spaces(Int)

		/// 以 tab 縮排
		case tab

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "indent"

		public var rawValue: String {
			switch self {
			case let .spaces(count):
				"\(count)"
			case .tab:
				"tab"
			}
		}

		public init?(rawValue: String) {
			switch rawValue.lowercased() {
			case "tab", "tabs", "tabbed":
				self = .tab
			default:
				guard let count = Int(rawValue) else { return nil }
				self = .spaces(count)
			}
		}
	}
}
