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

	@Test
	func `spaceAroundComments .disable 返空陣列`() {
		#expect(FormatRule.spaceAroundComments(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `spaceAroundComments .enable 展開 --enable spaceAroundComments`() {
		let args = FormatRule.spaceAroundComments(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceAroundComments"])
	}
}
