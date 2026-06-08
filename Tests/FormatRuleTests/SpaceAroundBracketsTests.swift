//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceAroundBrackets")
private struct SpaceAroundBracketsTests {

	@Test
	private func `spaceAroundBrackets .disable 返空陣列`() {
		#expect(FormatRule.spaceAroundBrackets(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `spaceAroundBrackets .enable 展開 --enable spaceAroundBrackets`() {
		let args = FormatRule.spaceAroundBrackets(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceAroundBrackets"])
	}
}
