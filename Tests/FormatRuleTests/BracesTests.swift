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
private struct BracesTests {

	@Test
	private func `braces .disable 返空陣列`() {
		let args = FormatRule.braces(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `braces .disable + allman（option 被忽略）返空陣列`() {
		let args = FormatRule.braces(rule: .disable, allman: .enable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `braces .enable（allman 預設 .disable）展開 --enable + --allman false`() {
		let args = FormatRule.braces(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "braces",
			"--allman", "false"
		])
	}

	@Test
	private func `braces .enable allman .enable 展開 --allman true`() {
		let args = FormatRule.braces(rule: .enable, allman: .enable).cliArguments
		#expect(args == [
			"--enable", "braces",
			"--allman", "true"
		])
	}
}
