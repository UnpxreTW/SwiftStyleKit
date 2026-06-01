//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapMultilineConditionalAssignment")
private struct WrapMultilineConditionalAssignmentTests {

	@Test
	private func `wrapMultilineConditionalAssignment .disable 返空陣列`() {
		#expect(FormatRule.wrapMultilineConditionalAssignment(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapMultilineConditionalAssignment .enable 只 enable 不展開 option`() {
		#expect(FormatRule.wrapMultilineConditionalAssignment(rule: .enable).cliArguments == [
			"--enable", "wrapMultilineConditionalAssignment"
		])
	}
}
