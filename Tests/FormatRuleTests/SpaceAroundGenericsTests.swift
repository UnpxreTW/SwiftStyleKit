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

	@Test
	func `spaceAroundGenerics .disable 返空陣列`() {
		#expect(FormatRule.spaceAroundGenerics(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `spaceAroundGenerics .enable 展開 --enable spaceAroundGenerics`() {
		let args = FormatRule.spaceAroundGenerics(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceAroundGenerics"])
	}
}
