//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesBetweenImports")
private struct BlankLinesBetweenImportsTests {

	@Test
	private func `blankLinesBetweenImports .disable 返空陣列`() {
		let args = FormatRule.blankLinesBetweenImports(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `blankLinesBetweenImports .enable 展開 --enable blankLinesBetweenImports`() {
		let args = FormatRule.blankLinesBetweenImports(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLinesBetweenImports"])
	}
}
