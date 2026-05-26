//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("linebreaks")
private struct LinebreaksTests {

	@Test
	private func `linebreaks .disable 返空陣列`() {
		#expect(FormatRule.linebreaks(rule: .disable, mode: .crlf).cliArguments.isEmpty)
	}

	@Test
	private func `linebreaks .enable（mode 預設 .lf）展開 --enable + --linebreaks lf`() {
		let args = FormatRule.linebreaks(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "linebreaks",
			"--linebreaks", "lf"
		])
	}

	@Test
	private func `linebreaks .enable mode .crlf 展開 --linebreaks crlf`() {
		let args = FormatRule.linebreaks(rule: .enable, mode: .crlf).cliArguments
		#expect(args == [
			"--enable", "linebreaks",
			"--linebreaks", "crlf"
		])
	}
}
