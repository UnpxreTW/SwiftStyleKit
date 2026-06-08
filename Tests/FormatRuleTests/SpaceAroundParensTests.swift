//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceAroundParens")
private struct SpaceAroundParensTests {

	@Test
	private func `spaceAroundParens .disable 返空陣列`() {
		#expect(FormatRule.spaceAroundParens(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `spaceAroundParens .enable 展開 --enable spaceAroundParens`() {
		let args = FormatRule.spaceAroundParens(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceAroundParens"])
	}
}
