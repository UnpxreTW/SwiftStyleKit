//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceAroundBraces")
private struct SpaceAroundBracesTests {

	@Test
	private func `spaceAroundBraces .disable 返空陣列`() {
		#expect(FormatRule.spaceAroundBraces(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `spaceAroundBraces .enable 展開 --enable spaceAroundBraces`() {
		let args = FormatRule.spaceAroundBraces(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceAroundBraces"])
	}
}
