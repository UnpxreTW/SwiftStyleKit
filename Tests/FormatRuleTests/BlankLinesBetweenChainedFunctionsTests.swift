//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesBetweenChainedFunctions")
private struct BlankLinesBetweenChainedFunctionsTests {

	@Test
	private func `blankLinesBetweenChainedFunctions .disable 返空陣列`() {
		let args = FormatRule.blankLinesBetweenChainedFunctions(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `blankLinesBetweenChainedFunctions .enable 展開 --enable blankLinesBetweenChainedFunctions`() {
		let args = FormatRule.blankLinesBetweenChainedFunctions(.on).cliArguments
		#expect(args == ["--enable", "blankLinesBetweenChainedFunctions"])
	}
}
