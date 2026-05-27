//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapMultilineFunctionChains")
private struct WrapMultilineFunctionChainsTests {

	@Test
	private func `wrapMultilineFunctionChains .disable 返空陣列`() {
		#expect(FormatRule.wrapMultilineFunctionChains(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapMultilineFunctionChains .enable 只 enable 不展開 option`() {
		#expect(FormatRule.wrapMultilineFunctionChains(rule: .enable).cliArguments == [
			"--enable", "wrapMultilineFunctionChains"
		])
	}
}
