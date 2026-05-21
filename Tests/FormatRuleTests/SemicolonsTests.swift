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
		let args = FormatRule.semicolons(rule: .disable, mode: .never).cliArguments
		#expect(args.isEmpty)
	}

	@Test("semicolons .enable（預設 .never）展開 --enable + --semicolons never")
	func semicolonsEnableDefault() {
		let args = FormatRule.semicolons(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "semicolons",
			"--semicolons", "never"
		])
	}

	@Test("semicolons .enable mode .inline 展開 --semicolons inline")
	func semicolonsEnableInline() {
		let args = FormatRule.semicolons(rule: .enable, mode: .inline).cliArguments
		#expect(args == [
			"--enable", "semicolons",
			"--semicolons", "inline"
		])
	}
}
