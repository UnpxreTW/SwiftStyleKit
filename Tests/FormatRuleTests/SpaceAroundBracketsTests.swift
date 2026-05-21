//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceAroundBrackets")
struct SpaceAroundBracketsTests {

	@Test("spaceAroundBrackets .disable 返空陣列")
	func spaceAroundBracketsDisable() {
		#expect(FormatRule.spaceAroundBrackets(rule: .disable).cliArguments.isEmpty)
	}

	@Test("spaceAroundBrackets .enable 展開 --enable spaceAroundBrackets")
	func spaceAroundBracketsEnable() {
		let args = FormatRule.spaceAroundBrackets(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceAroundBrackets"])
	}
}
