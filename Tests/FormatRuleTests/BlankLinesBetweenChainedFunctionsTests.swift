//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesBetweenChainedFunctions")
private struct BlankLinesBetweenChainedFunctionsTests {

	@Test
	private func `blankLinesBetweenChainedFunctions .disable 返空陣列`() {
		let args = FormatRule.blankLinesBetweenChainedFunctions(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `blankLinesBetweenChainedFunctions .enable 展開 --enable blankLinesBetweenChainedFunctions`() {
		let args = FormatRule.blankLinesBetweenChainedFunctions(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLinesBetweenChainedFunctions"])
	}
}
