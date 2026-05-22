//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesAtStartOfScope")
struct BlankLinesAtStartOfScopeTests {

	@Test
	func `blankLinesAtStartOfScope .disable 返空陣列`() {
		let args = FormatRule.blankLinesAtStartOfScope(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `blankLinesAtStartOfScope .enable 展開 --enable blankLinesAtStartOfScope`() {
		let args = FormatRule.blankLinesAtStartOfScope(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLinesAtStartOfScope"])
	}
}
