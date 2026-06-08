//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("headerFileName")
private struct HeaderFileNameTests {

	@Test
	private func `headerFileName .disable 返空陣列`() {
		#expect(FormatRule.headerFileName(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `headerFileName .enable 展開 --enable headerFileName`() {
		#expect(FormatRule.headerFileName(rule: .enable).cliArguments == ["--enable", "headerFileName"])
	}
}
