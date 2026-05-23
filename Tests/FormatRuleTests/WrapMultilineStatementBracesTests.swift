//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapMultilineStatementBraces")
struct WrapMultilineStatementBracesTests {

	@Test
	func `wrapMultilineStatementBraces .disable 返空陣列`() {
		#expect(FormatRule.wrapMultilineStatementBraces(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `wrapMultilineStatementBraces .enable 展開 --enable wrapMultilineStatementBraces`() {
		let args = FormatRule.wrapMultilineStatementBraces(rule: .enable).cliArguments
		#expect(args == ["--enable", "wrapMultilineStatementBraces"])
	}
}
