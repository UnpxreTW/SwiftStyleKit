//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("emptyBraces")
private struct EmptyBracesTests {

	@Test
	private func `emptyBraces .disable 返空陣列`() {
		let args = FormatRule.emptyBraces(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `emptyBraces .enable（mode 預設 .noSpace）展開 --enable + --emptyBraces no-space`() {
		let args = FormatRule.emptyBraces(.on).cliArguments
		#expect(args == [
			"--enable", "emptyBraces",
			"--emptyBraces", "no-space"
		])
	}

	@Test
	private func `emptyBraces .enable mode .spaced 展開 --emptyBraces spaced`() {
		let args = FormatRule.emptyBraces(.on, mode: .spaced).cliArguments
		#expect(args == [
			"--enable", "emptyBraces",
			"--emptyBraces", "spaced"
		])
	}

	@Test
	private func `emptyBraces .enable mode .linebreak 展開 --emptyBraces linebreak`() {
		let args = FormatRule.emptyBraces(.on, mode: .linebreak).cliArguments
		#expect(args == [
			"--enable", "emptyBraces",
			"--emptyBraces", "linebreak"
		])
	}
}
