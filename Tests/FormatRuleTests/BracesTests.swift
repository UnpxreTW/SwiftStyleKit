//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("braces")
struct BracesTests {

	@Test("braces .disable 返空陣列")
	func bracesDisable() {
		let args = FormatRule.braces(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("braces .disable + allman（option 被忽略）返空陣列")
	func bracesDisableWithOption() {
		let args = FormatRule.braces(rule: .disable, allman: .enable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("braces .enable（allman 預設 .disable）展開 --enable + --allman false")
	func bracesEnableDefault() {
		let args = FormatRule.braces(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "braces",
			"--allman", "false"
		])
	}

	@Test("braces .enable allman .enable 展開 --allman true")
	func bracesEnableAllman() {
		let args = FormatRule.braces(rule: .enable, allman: .enable).cliArguments
		#expect(args == [
			"--enable", "braces",
			"--allman", "true"
		])
	}
}
