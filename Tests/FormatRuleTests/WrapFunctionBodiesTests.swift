//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapFunctionBodies")
struct WrapFunctionBodiesTests {

	@Test
	func `wrapFunctionBodies .disable 返空陣列`() {
		#expect(FormatRule.wrapFunctionBodies(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `wrapFunctionBodies .enable 展開 --enable wrapFunctionBodies`() {
		let args = FormatRule.wrapFunctionBodies(rule: .enable).cliArguments
		#expect(args == ["--enable", "wrapFunctionBodies"])
	}
}
