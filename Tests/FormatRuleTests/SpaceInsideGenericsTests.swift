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

	@Test
	func `spaceInsideGenerics .disable 返空陣列`() {
		#expect(FormatRule.spaceInsideGenerics(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `spaceInsideGenerics .enable 展開 --enable spaceInsideGenerics`() {
		let args = FormatRule.spaceInsideGenerics(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceInsideGenerics"])
	}
}
