//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLineAfterImports")
struct BlankLineAfterImportsTests {

	@Test
	func `blankLineAfterImports .disable 返空陣列`() {
		let args = FormatRule.blankLineAfterImports(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `blankLineAfterImports .enable 展開 --enable blankLineAfterImports`() {
		let args = FormatRule.blankLineAfterImports(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLineAfterImports"])
	}
}
