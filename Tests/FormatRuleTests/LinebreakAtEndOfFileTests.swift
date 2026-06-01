//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("linebreakAtEndOfFile")
private struct LinebreakAtEndOfFileTests {

	@Test
	private func `linebreakAtEndOfFile .disable 返空陣列`() {
		#expect(FormatRule.linebreakAtEndOfFile(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `linebreakAtEndOfFile .enable 展開 --enable linebreakAtEndOfFile`() {
		let args = FormatRule.linebreakAtEndOfFile(rule: .enable).cliArguments
		#expect(args == ["--enable", "linebreakAtEndOfFile"])
	}
}
