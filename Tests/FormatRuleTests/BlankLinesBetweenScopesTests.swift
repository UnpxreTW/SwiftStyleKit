//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesBetweenScopes")
struct BlankLinesBetweenScopesTests {

	@Test
	func `blankLinesBetweenScopes .disable 返空陣列`() {
		let args = FormatRule.blankLinesBetweenScopes(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `blankLinesBetweenScopes .enable 展開 --enable blankLinesBetweenScopes`() {
		let args = FormatRule.blankLinesBetweenScopes(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLinesBetweenScopes"])
	}
}
