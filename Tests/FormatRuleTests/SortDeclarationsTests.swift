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

	@Test("sortDeclarations .disable 返空陣列")
	func sortDeclarationsDisable() {
		#expect(FormatRule.sortDeclarations(rule: .disable).cliArguments.isEmpty)
	}

	@Test("sortDeclarations .enable 展開 --enable sortDeclarations")
	func sortDeclarationsEnable() {
		let args = FormatRule.sortDeclarations(rule: .enable).cliArguments
		#expect(args == ["--enable", "sortDeclarations"])
	}
}
