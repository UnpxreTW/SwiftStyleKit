//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceInsideBraces")
struct SpaceInsideBracesTests {

	@Test
	func `spaceInsideBraces .disable 返空陣列`() {
		#expect(FormatRule.spaceInsideBraces(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `spaceInsideBraces .enable 展開 --enable spaceInsideBraces`() {
		let args = FormatRule.spaceInsideBraces(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceInsideBraces"])
	}
}
