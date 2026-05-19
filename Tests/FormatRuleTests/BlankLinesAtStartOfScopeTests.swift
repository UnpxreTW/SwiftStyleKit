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

	@Test("blankLinesAtStartOfScope .disable 返空陣列")
	func blankLinesAtStartOfScopeDisable() {
		let args = FormatRule.blankLinesAtStartOfScope(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("blankLinesAtStartOfScope .enable 展開 --enable blankLinesAtStartOfScope")
	func blankLinesAtStartOfScopeEnable() {
		let args = FormatRule.blankLinesAtStartOfScope(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLinesAtStartOfScope"])
	}
}
