//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceAroundComments")
struct SpaceAroundCommentsTests {

	@Test("spaceAroundComments .disable 返空陣列")
	func spaceAroundCommentsDisable() {
		#expect(FormatRule.spaceAroundComments(rule: .disable).cliArguments.isEmpty)
	}

	@Test("spaceAroundComments .enable 展開 --enable spaceAroundComments")
	func spaceAroundCommentsEnable() {
		let args = FormatRule.spaceAroundComments(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceAroundComments"])
	}
}
