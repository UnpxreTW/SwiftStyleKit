//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantAsync")
struct RedundantAsyncTests {

	@Test
	func `redundantAsync .disable 返空陣列`() {
		let args = FormatRule.redundantAsync(rule: .disable, mode: .always).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `redundantAsync .enable（mode 預設 .testsOnly）展開 --enable + --redundantAsync tests-only`() {
		let args = FormatRule.redundantAsync(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "redundantAsync",
			"--redundantAsync", "tests-only",
		])
	}

	@Test
	func `redundantAsync .enable mode .always 展開 --redundantAsync always`() {
		let args = FormatRule.redundantAsync(rule: .enable, mode: .always).cliArguments
		#expect(args == [
			"--enable", "redundantAsync",
			"--redundantAsync", "always",
		])
	}
}
