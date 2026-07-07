//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapIfStatementBodies")
private struct WrapIfStatementBodiesTests {

	@Test
	private func `wrapIfStatementBodies .disable 返空陣列`() {
		#expect(FormatRule.wrapIfStatementBodies(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapIfStatementBodies .enable 只 enable 不展開 option`() {
		#expect(FormatRule.wrapIfStatementBodies(rule: .enable).cliArguments == ["--enable", "wrapIfStatementBodies"])
	}
}
