//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapIfExpressionBodies")
private struct WrapIfExpressionBodiesTests {

	@Test
	private func `wrapIfExpressionBodies .disable 返空陣列`() {
		#expect(FormatRule.wrapIfExpressionBodies(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapIfExpressionBodies .enable 只 enable 不展開 option`() {
		#expect(FormatRule.wrapIfExpressionBodies(rule: .enable).cliArguments == ["--enable", "wrapIfExpressionBodies"])
	}
}
