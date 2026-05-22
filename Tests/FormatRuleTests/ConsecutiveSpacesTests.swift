//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("consecutiveSpaces")
struct ConsecutiveSpacesTests {

	@Test
	func `consecutiveSpaces .disable 返空陣列`() {
		let args = FormatRule.consecutiveSpaces(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `consecutiveSpaces .enable 展開 --enable consecutiveSpaces`() {
		let args = FormatRule.consecutiveSpaces(rule: .enable).cliArguments
		#expect(args == ["--enable", "consecutiveSpaces"])
	}
}
