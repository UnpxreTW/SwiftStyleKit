//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceInsideComments")
struct SpaceInsideCommentsTests {

	@Test("spaceInsideComments .disable 返空陣列")
	func spaceInsideCommentsDisable() {
		#expect(FormatRule.spaceInsideComments(rule: .disable).cliArguments.isEmpty)
	}

	@Test("spaceInsideComments .enable 展開 --enable spaceInsideComments")
	func spaceInsideCommentsEnable() {
		let args = FormatRule.spaceInsideComments(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceInsideComments"])
	}
}
