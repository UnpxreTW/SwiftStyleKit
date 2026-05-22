//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantPattern")
struct RedundantPatternTests {

	@Test
	func `redundantPattern .disable 返空陣列`() {
		#expect(FormatRule.redundantPattern(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantPattern .enable 展開 --enable redundantPattern`() {
		let args = FormatRule.redundantPattern(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantPattern"])
	}
}
