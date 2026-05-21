//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("semicolons")
struct SemicolonsTests {

	@Test("semicolons .disable 返空陣列")
	func semicolonsDisable() {
		let args = FormatRule.semicolons(rule: .disable, mode: .inline).cliArguments
		#expect(args.isEmpty)
	}

	@Test("semicolons .enable（預設 .inline）展開 --enable + --semicolons inline")
	func semicolonsEnableDefault() {
		let args = FormatRule.semicolons(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "semicolons",
			"--semicolons", "inline"
		])
	}

	@Test("semicolons .enable mode .never 展開 --semicolons never")
	func semicolonsEnableNever() {
		let args = FormatRule.semicolons(rule: .enable, mode: .never).cliArguments
		#expect(args == [
			"--enable", "semicolons",
			"--semicolons", "never"
		])
	}
}
