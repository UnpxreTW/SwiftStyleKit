//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceInsideGenerics")
struct SpaceInsideGenericsTests {

	@Test("spaceInsideGenerics .disable 返空陣列")
	func spaceInsideGenericsDisable() {
		#expect(FormatRule.spaceInsideGenerics(rule: .disable).cliArguments.isEmpty)
	}

	@Test("spaceInsideGenerics .enable 展開 --enable spaceInsideGenerics")
	func spaceInsideGenericsEnable() {
		let args = FormatRule.spaceInsideGenerics(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceInsideGenerics"])
	}
}
