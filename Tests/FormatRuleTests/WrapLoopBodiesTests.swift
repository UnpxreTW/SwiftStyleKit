//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapLoopBodies")
struct WrapLoopBodiesTests {

	@Test
	func `wrapLoopBodies .disable 返空陣列`() {
		#expect(FormatRule.wrapLoopBodies(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `wrapLoopBodies .enable 展開 --enable wrapLoopBodies`() {
		let args = FormatRule.wrapLoopBodies(rule: .enable).cliArguments
		#expect(args == ["--enable", "wrapLoopBodies"])
	}
}
