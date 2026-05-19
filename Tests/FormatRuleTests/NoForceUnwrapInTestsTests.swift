//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("noForceUnwrapInTests")
struct NoForceUnwrapInTestsTests {

	@Test("noForceUnwrapInTests .disable 返空陣列")
	func noForceUnwrapInTestsDisable() {
		#expect(FormatRule.noForceUnwrapInTests(rule: .disable).cliArguments.isEmpty)
	}

	@Test("noForceUnwrapInTests .enable 展開 --enable noForceUnwrapInTests")
	func noForceUnwrapInTestsEnable() {
		let args = FormatRule.noForceUnwrapInTests(rule: .enable).cliArguments
		#expect(args == ["--enable", "noForceUnwrapInTests"])
	}
}
