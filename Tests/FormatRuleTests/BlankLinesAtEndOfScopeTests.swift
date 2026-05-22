//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesAtEndOfScope")
struct BlankLinesAtEndOfScopeTests {

	@Test
	func `blankLinesAtEndOfScope .disable 返空陣列`() {
		let args = FormatRule.blankLinesAtEndOfScope(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `blankLinesAtEndOfScope .enable 展開 --enable blankLinesAtEndOfScope`() {
		let args = FormatRule.blankLinesAtEndOfScope(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLinesAtEndOfScope"])
	}
}
