//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapConditionalBodies")
private struct WrapConditionalBodiesTests {

	@available(*, deprecated)
	@Test
	private func `wrapConditionalBodies .disable 返空陣列`() {
		#expect(FormatRule.wrapConditionalBodies(rule: .disable).cliArguments.isEmpty)
	}

	@available(*, deprecated)
	@Test
	private func `wrapConditionalBodies .enable 只 enable 不展開 option`() {
		#expect(FormatRule.wrapConditionalBodies(rule: .enable).cliArguments == ["--enable", "wrapConditionalBodies"])
	}
}
