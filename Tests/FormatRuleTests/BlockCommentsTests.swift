//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blockComments")
private struct BlockCommentsTests {

	@Test
	private func `blockComments .disable 返空陣列`() {
		#expect(FormatRule.blockComments(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `blockComments .enable 展開 --enable blockComments`() {
		let args = FormatRule.blockComments(rule: .enable).cliArguments
		#expect(args == ["--enable", "blockComments"])
	}
}
