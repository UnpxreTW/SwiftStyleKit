//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceAroundParens")
struct SpaceAroundParensTests {

	@Test
	func `spaceAroundParens .disable 返空陣列`() {
		#expect(FormatRule.spaceAroundParens(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `spaceAroundParens .enable 展開 --enable spaceAroundParens`() {
		let args = FormatRule.spaceAroundParens(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceAroundParens"])
	}
}
