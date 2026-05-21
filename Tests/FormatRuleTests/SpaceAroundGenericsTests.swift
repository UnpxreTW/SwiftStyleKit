//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceAroundGenerics")
struct SpaceAroundGenericsTests {

	@Test("spaceAroundGenerics .disable 返空陣列")
	func spaceAroundGenericsDisable() {
		#expect(FormatRule.spaceAroundGenerics(rule: .disable).cliArguments.isEmpty)
	}

	@Test("spaceAroundGenerics .enable 展開 --enable spaceAroundGenerics")
	func spaceAroundGenericsEnable() {
		let args = FormatRule.spaceAroundGenerics(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceAroundGenerics"])
	}
}
