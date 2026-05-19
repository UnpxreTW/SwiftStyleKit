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

	@Test("hoistPatternLet .disable 返空陣列")
	func hoistPatternLetDisable() {
		let args = FormatRule.hoistPatternLet(rule: .disable, mode: .inline).cliArguments
		#expect(args.isEmpty)
	}

	@Test("hoistPatternLet .enable（mode 預設 .hoist）展開 --enable + --patternLet hoist")
	func hoistPatternLetEnableDefault() {
		let args = FormatRule.hoistPatternLet(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "hoistPatternLet",
			"--patternLet", "hoist"
		])
	}

	@Test("hoistPatternLet .enable mode .inline 展開 --patternLet inline")
	func hoistPatternLetEnableInline() {
		let args = FormatRule.hoistPatternLet(rule: .enable, mode: .inline).cliArguments
		#expect(args == [
			"--enable", "hoistPatternLet",
			"--patternLet", "inline"
		])
	}
}
