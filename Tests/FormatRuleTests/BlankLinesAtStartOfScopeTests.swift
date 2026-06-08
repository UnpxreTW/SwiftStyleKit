//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesAtStartOfScope")
private struct BlankLinesAtStartOfScopeTests {

	@Test
	private func `blankLinesAtStartOfScope .disable 返空陣列`() {
		let args = FormatRule.blankLinesAtStartOfScope(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `blankLinesAtStartOfScope .enable 展開 --enable blankLinesAtStartOfScope`() {
		let args = FormatRule.blankLinesAtStartOfScope(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLinesAtStartOfScope"])
	}
}
