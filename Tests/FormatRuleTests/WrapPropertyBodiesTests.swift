//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapPropertyBodies")
private struct WrapPropertyBodiesTests {

	@Test
	private func `wrapPropertyBodies .disable 返空陣列`() {
		#expect(FormatRule.wrapPropertyBodies(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapPropertyBodies .enable 展開 --enable wrapPropertyBodies`() {
		let args = FormatRule.wrapPropertyBodies(rule: .enable).cliArguments
		#expect(args == ["--enable", "wrapPropertyBodies"])
	}
}
