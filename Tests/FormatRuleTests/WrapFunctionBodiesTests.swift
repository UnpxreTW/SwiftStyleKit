//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapFunctionBodies")
private struct WrapFunctionBodiesTests {

	@Test
	private func `wrapFunctionBodies .disable 返空陣列`() {
		#expect(FormatRule.wrapFunctionBodies(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapFunctionBodies .enable 展開 --enable wrapFunctionBodies`() {
		let args = FormatRule.wrapFunctionBodies(rule: .enable).cliArguments
		#expect(args == ["--enable", "wrapFunctionBodies"])
	}
}
