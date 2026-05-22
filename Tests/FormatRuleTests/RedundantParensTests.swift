//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantParens")
struct RedundantParensTests {

	@Test
	func `redundantParens .disable 返空陣列`() {
		#expect(FormatRule.redundantParens(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantParens .enable 展開 --enable redundantParens`() {
		let args = FormatRule.redundantParens(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantParens"])
	}
}
