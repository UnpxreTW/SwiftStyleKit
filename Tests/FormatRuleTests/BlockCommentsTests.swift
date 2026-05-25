//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blockComments")
struct BlockCommentsTests {

	@Test
	func `blockComments .disable 返空陣列`() {
		#expect(FormatRule.blockComments(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `blockComments .enable 展開 --enable blockComments`() {
		let args = FormatRule.blockComments(rule: .enable).cliArguments
		#expect(args == ["--enable", "blockComments"])
	}
}
