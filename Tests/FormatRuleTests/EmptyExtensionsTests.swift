//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("emptyExtensions")
struct EmptyExtensionsTests {

	@Test
	func `emptyExtensions .disable 返空陣列`() {
		let args = FormatRule.emptyExtensions(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `emptyExtensions .enable 展開 --enable emptyExtensions`() {
		let args = FormatRule.emptyExtensions(rule: .enable).cliArguments
		#expect(args == ["--enable", "emptyExtensions"])
	}
}
