//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("noForceTryInTests")
struct NoForceTryInTestsTests {

	@Test
	func `noForceTryInTests .disable 返空陣列`() {
		#expect(FormatRule.noForceTryInTests(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `noForceTryInTests .enable 展開 --enable noForceTryInTests`() {
		let args = FormatRule.noForceTryInTests(rule: .enable).cliArguments
		#expect(args == ["--enable", "noForceTryInTests"])
	}
}
