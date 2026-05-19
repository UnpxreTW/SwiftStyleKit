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

	@Test("emptyBraces .disable 返空陣列")
	func emptyBracesDisable() {
		let args = FormatRule.emptyBraces(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("emptyBraces .disable + mode（option 被忽略）返空陣列")
	func emptyBracesDisableWithMode() {
		let args = FormatRule.emptyBraces(rule: .disable, mode: .spaced).cliArguments
		#expect(args.isEmpty)
	}

	@Test("emptyBraces .enable（mode 預設 .noSpace）展開 --enable + --emptyBraces no-space")
	func emptyBracesEnableDefault() {
		let args = FormatRule.emptyBraces(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "emptyBraces",
			"--emptyBraces", "no-space"
		])
	}

	@Test("emptyBraces .enable mode .spaced 展開 --emptyBraces spaced")
	func emptyBracesEnableSpaced() {
		let args = FormatRule.emptyBraces(rule: .enable, mode: .spaced).cliArguments
		#expect(args == [
			"--enable", "emptyBraces",
			"--emptyBraces", "spaced"
		])
	}

	@Test("emptyBraces .enable mode .linebreak 展開 --emptyBraces linebreak")
	func emptyBracesEnableLinebreak() {
		let args = FormatRule.emptyBraces(rule: .enable, mode: .linebreak).cliArguments
		#expect(args == [
			"--enable", "emptyBraces",
			"--emptyBraces", "linebreak"
		])
	}
}
