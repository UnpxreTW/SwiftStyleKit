//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapPropertyBodies")
struct WrapPropertyBodiesTests {

	@Test
	func `wrapPropertyBodies .disable 返空陣列`() {
		#expect(FormatRule.wrapPropertyBodies(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `wrapPropertyBodies .enable 展開 --enable wrapPropertyBodies`() {
		let args = FormatRule.wrapPropertyBodies(rule: .enable).cliArguments
		#expect(args == ["--enable", "wrapPropertyBodies"])
	}
}
