//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blockComments")
private struct BlockCommentsTests {

	@Test
	private func `blockComments .disable 返空陣列`() {
		#expect(FormatRule.blockComments(.off).cliArguments.isEmpty)
	}

	@Test
	private func `blockComments .enable 展開 --enable blockComments`() {
		let args = FormatRule.blockComments(.on).cliArguments
		#expect(args == ["--enable", "blockComments"])
	}
}
