//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("emptyBraces")
struct EmptyBracesTests {

	@Test
	func `emptyBraces .disable 返空陣列`() {
		let args = FormatRule.emptyBraces(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `emptyBraces .disable + mode（option 被忽略）返空陣列`() {
		let args = FormatRule.emptyBraces(rule: .disable, mode: .spaced).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `emptyBraces .enable（mode 預設 .noSpace）展開 --enable + --emptyBraces no-space`() {
		let args = FormatRule.emptyBraces(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "emptyBraces",
			"--emptyBraces", "no-space"
		])
	}

	@Test
	func `emptyBraces .enable mode .spaced 展開 --emptyBraces spaced`() {
		let args = FormatRule.emptyBraces(rule: .enable, mode: .spaced).cliArguments
		#expect(args == [
			"--enable", "emptyBraces",
			"--emptyBraces", "spaced"
		])
	}

	@Test
	func `emptyBraces .enable mode .linebreak 展開 --emptyBraces linebreak`() {
		let args = FormatRule.emptyBraces(rule: .enable, mode: .linebreak).cliArguments
		#expect(args == [
			"--enable", "emptyBraces",
			"--emptyBraces", "linebreak"
		])
	}
}
