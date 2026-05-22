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

	@Test
	func `semicolons .disable 返空陣列`() {
		let args = FormatRule.semicolons(rule: .disable, mode: .never).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `semicolons .enable（預設 .never）展開 --enable + --semicolons never`() {
		let args = FormatRule.semicolons(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "semicolons",
			"--semicolons", "never"
		])
	}

	@Test
	func `semicolons .enable mode .inline 展開 --semicolons inline`() {
		let args = FormatRule.semicolons(rule: .enable, mode: .inline).cliArguments
		#expect(args == [
			"--enable", "semicolons",
			"--semicolons", "inline"
		])
	}
}
