//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("sortDeclarations")
private struct SortDeclarationsTests {

	@Test
	private func `sortDeclarations .disable 返空陣列`() {
		#expect(FormatRule.sortDeclarations(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `sortDeclarations .enable 展開 --enable sortDeclarations`() {
		let args = FormatRule.sortDeclarations(rule: .enable).cliArguments
		#expect(args == ["--enable", "sortDeclarations"])
	}
}
