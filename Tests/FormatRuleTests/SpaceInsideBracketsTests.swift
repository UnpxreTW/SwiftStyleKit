//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceInsideBrackets")
struct SpaceInsideBracketsTests {

	@Test("spaceInsideBrackets .disable 返空陣列")
	func spaceInsideBracketsDisable() {
		#expect(FormatRule.spaceInsideBrackets(rule: .disable).cliArguments.isEmpty)
	}

	@Test("spaceInsideBrackets .enable 展開 --enable spaceInsideBrackets")
	func spaceInsideBracketsEnable() {
		let args = FormatRule.spaceInsideBrackets(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceInsideBrackets"])
	}
}
