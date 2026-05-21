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

	@Test("redundantPattern .disable 返空陣列")
	func redundantPatternDisable() {
		#expect(FormatRule.redundantPattern(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantPattern .enable 展開 --enable redundantPattern")
	func redundantPatternEnable() {
		let args = FormatRule.redundantPattern(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantPattern"])
	}
}
