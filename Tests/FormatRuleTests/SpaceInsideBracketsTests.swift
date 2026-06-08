//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceInsideBrackets")
private struct SpaceInsideBracketsTests {

	@Test
	private func `spaceInsideBrackets .disable 返空陣列`() {
		#expect(FormatRule.spaceInsideBrackets(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `spaceInsideBrackets .enable 展開 --enable spaceInsideBrackets`() {
		let args = FormatRule.spaceInsideBrackets(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceInsideBrackets"])
	}
}
