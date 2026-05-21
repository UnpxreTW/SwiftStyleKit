//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceAroundBraces")
struct SpaceAroundBracesTests {

	@Test("spaceAroundBraces .disable 返空陣列")
	func spaceAroundBracesDisable() {
		#expect(FormatRule.spaceAroundBraces(rule: .disable).cliArguments.isEmpty)
	}

	@Test("spaceAroundBraces .enable 展開 --enable spaceAroundBraces")
	func spaceAroundBracesEnable() {
		let args = FormatRule.spaceAroundBraces(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceAroundBraces"])
	}
}
