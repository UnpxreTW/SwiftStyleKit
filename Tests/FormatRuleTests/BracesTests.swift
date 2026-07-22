//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("braces")
private struct BracesTests {

	@Test
	private func `braces .disable 返空陣列`() {
		let args = FormatRule.braces(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `braces .enable（allman 預設 .disable）展開 --enable + --allman false`() {
		let args = FormatRule.braces(.on).cliArguments
		#expect(args == [
			"--enable", "braces",
			"--allman", "false"
		])
	}

	@Test
	private func `braces .enable allman .enable 展開 --allman true`() {
		let args = FormatRule.braces(.on, allman: .enable).cliArguments
		#expect(args == [
			"--enable", "braces",
			"--allman", "true"
		])
	}
}
