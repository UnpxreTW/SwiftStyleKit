//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesBetweenScopes")
private struct BlankLinesBetweenScopesTests {

	@Test
	private func `blankLinesBetweenScopes .disable 返空陣列`() {
		let args = FormatRule.blankLinesBetweenScopes(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `blankLinesBetweenScopes .enable 展開 --enable blankLinesBetweenScopes`() {
		let args = FormatRule.blankLinesBetweenScopes(.on).cliArguments
		#expect(args == ["--enable", "blankLinesBetweenScopes"])
	}
}
