//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapMultilineStatementBraces")
private struct WrapMultilineStatementBracesTests {

	@Test
	private func `wrapMultilineStatementBraces .disable 返空陣列`() {
		#expect(FormatRule.wrapMultilineStatementBraces(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapMultilineStatementBraces .enable 展開 --enable wrapMultilineStatementBraces`() {
		let args = FormatRule.wrapMultilineStatementBraces(rule: .enable).cliArguments
		#expect(args == ["--enable", "wrapMultilineStatementBraces"])
	}
}
