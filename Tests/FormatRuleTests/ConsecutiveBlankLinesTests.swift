//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("consecutiveBlankLines")
private struct ConsecutiveBlankLinesTests {

	@Test
	private func `consecutiveBlankLines .disable 返空陣列`() {
		let args = FormatRule.consecutiveBlankLines(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `consecutiveBlankLines .enable 展開 --enable consecutiveBlankLines`() {
		let args = FormatRule.consecutiveBlankLines(rule: .enable).cliArguments
		#expect(args == ["--enable", "consecutiveBlankLines"])
	}
}
