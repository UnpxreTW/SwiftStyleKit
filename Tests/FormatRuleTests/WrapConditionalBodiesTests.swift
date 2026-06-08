//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapConditionalBodies")
private struct WrapConditionalBodiesTests {

	@Test
	private func `wrapConditionalBodies .disable 返空陣列`() {
		#expect(FormatRule.wrapConditionalBodies(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapConditionalBodies .enable 只 enable 不展開 option`() {
		#expect(FormatRule.wrapConditionalBodies(rule: .enable).cliArguments == ["--enable", "wrapConditionalBodies"])
	}
}
