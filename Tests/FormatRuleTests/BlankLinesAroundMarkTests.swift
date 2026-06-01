//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesAroundMark")
private struct BlankLinesAroundMarkTests {

	@Test
	private func `blankLinesAroundMark .disable 返空陣列`() {
		let args = FormatRule.blankLinesAroundMark(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `blankLinesAroundMark .disable + lineAfterMarks（option 被忽略）返空陣列`() {
		let args = FormatRule.blankLinesAroundMark(rule: .disable, lineAfterMarks: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `blankLinesAroundMark .enable（lineAfterMarks 預設 .enable）展開 --enable + --lineAfterMarks true`() {
		let args = FormatRule.blankLinesAroundMark(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "blankLinesAroundMark",
			"--lineAfterMarks", "true"
		])
	}

	@Test
	private func `blankLinesAroundMark .enable lineAfterMarks .disable 展開 --lineAfterMarks false`() {
		let args = FormatRule.blankLinesAroundMark(rule: .enable, lineAfterMarks: .disable).cliArguments
		#expect(args == [
			"--enable", "blankLinesAroundMark",
			"--lineAfterMarks", "false"
		])
	}
}
