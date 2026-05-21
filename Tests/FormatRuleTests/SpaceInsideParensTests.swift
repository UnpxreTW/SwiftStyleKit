//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceInsideParens")
struct SpaceInsideParensTests {

	@Test("spaceInsideParens .disable 返空陣列")
	func spaceInsideParensDisable() {
		#expect(FormatRule.spaceInsideParens(rule: .disable).cliArguments.isEmpty)
	}

	@Test("spaceInsideParens .enable 展開 --enable spaceInsideParens")
	func spaceInsideParensEnable() {
		let args = FormatRule.spaceInsideParens(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceInsideParens"])
	}
}
