//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("sortDeclarations")
struct SortDeclarationsTests {

	@Test
	func `sortDeclarations .disable 返空陣列`() {
		#expect(FormatRule.sortDeclarations(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `sortDeclarations .enable 展開 --enable sortDeclarations`() {
		let args = FormatRule.sortDeclarations(rule: .enable).cliArguments
		#expect(args == ["--enable", "sortDeclarations"])
	}
}
