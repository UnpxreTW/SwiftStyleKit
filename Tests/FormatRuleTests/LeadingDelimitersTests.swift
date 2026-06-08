//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("leadingDelimiters")
private struct LeadingDelimitersTests {

	@Test
	private func `leadingDelimiters .disable 返空陣列`() {
		#expect(FormatRule.leadingDelimiters(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `leadingDelimiters .enable 展開 --enable leadingDelimiters`() {
		#expect(FormatRule.leadingDelimiters(rule: .enable).cliArguments == ["--enable", "leadingDelimiters"])
	}
}
