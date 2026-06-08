//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesAtEndOfScope")
private struct BlankLinesAtEndOfScopeTests {

	@Test
	private func `blankLinesAtEndOfScope .disable 返空陣列`() {
		let args = FormatRule.blankLinesAtEndOfScope(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `blankLinesAtEndOfScope .enable 展開 --enable blankLinesAtEndOfScope`() {
		let args = FormatRule.blankLinesAtEndOfScope(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLinesAtEndOfScope"])
	}
}
