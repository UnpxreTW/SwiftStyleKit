//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("hoistPatternLet")
struct HoistPatternLetTests {

	@Test
	func `hoistPatternLet .disable 返空陣列`() {
		let args = FormatRule.hoistPatternLet(rule: .disable, mode: .inline).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `hoistPatternLet .enable（mode 預設 .hoist）展開 --enable + --patternLet hoist`() {
		let args = FormatRule.hoistPatternLet(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "hoistPatternLet",
			"--patternLet", "hoist"
		])
	}

	@Test
	func `hoistPatternLet .enable mode .inline 展開 --patternLet inline`() {
		let args = FormatRule.hoistPatternLet(rule: .enable, mode: .inline).cliArguments
		#expect(args == [
			"--enable", "hoistPatternLet",
			"--patternLet", "inline"
		])
	}
}
