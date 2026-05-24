//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRuleOption where Self: RawRepresentable, Self.RawValue == String {

	/// String RawRepresentable enum 預設取 `rawValue` 當 swiftformat CLI 字串值
	public var cliValue: String { rawValue }
}
