//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantParens")
private struct RedundantParensTests {

	@Test
	private func `redundantParens .disable 返空陣列`() {
		#expect(FormatRule.redundantParens(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantParens .enable 展開 --enable redundantParens`() {
		let args = FormatRule.redundantParens(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantParens"])
	}
}
