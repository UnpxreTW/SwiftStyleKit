//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("noGuardInTests")
struct NoGuardInTestsTests {

	@Test
	func `noGuardInTests .disable 返空陣列`() {
		#expect(FormatRule.noGuardInTests(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `noGuardInTests .enable 展開 --enable noGuardInTests`() {
		let args = FormatRule.noGuardInTests(rule: .enable).cliArguments
		#expect(args == ["--enable", "noGuardInTests"])
	}
}
