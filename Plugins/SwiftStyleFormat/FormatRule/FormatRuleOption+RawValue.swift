//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRuleOption where Self: RawRepresentable, Self.RawValue == String {

	/// String RawRepresentable enum 預設取 `rawValue` 當 swiftformat CLI 字串值
	public var cliValue: String { rawValue }
}
