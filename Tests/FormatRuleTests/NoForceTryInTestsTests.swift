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

	@Test("noForceTryInTests .disable 返空陣列")
	func noForceTryInTestsDisable() {
		#expect(FormatRule.noForceTryInTests(rule: .disable).cliArguments.isEmpty)
	}

	@Test("noForceTryInTests .enable 展開 --enable noForceTryInTests")
	func noForceTryInTestsEnable() {
		let args = FormatRule.noForceTryInTests(rule: .enable).cliArguments
		#expect(args == ["--enable", "noForceTryInTests"])
	}
}
