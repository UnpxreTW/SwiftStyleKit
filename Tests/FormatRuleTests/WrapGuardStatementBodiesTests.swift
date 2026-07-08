//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapGuardStatementBodies")
private struct WrapGuardStatementBodiesTests {

	@Test
	private func `wrapGuardStatementBodies .disable 返空陣列`() {
		#expect(FormatRule.wrapGuardStatementBodies(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapGuardStatementBodies .enable 只 enable 不展開 option`() {
		#expect(FormatRule.wrapGuardStatementBodies(rule: .enable).cliArguments == ["--enable", "wrapGuardStatementBodies"])
	}
}
