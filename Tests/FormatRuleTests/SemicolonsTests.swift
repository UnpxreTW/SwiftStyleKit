//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("semicolons")
private struct SemicolonsTests {

	@Test
	private func `semicolons .disable 返空陣列`() {
		let args = FormatRule.semicolons(rule: .disable, mode: .never).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `semicolons .enable（預設 .never）展開 --enable + --semicolons never`() {
		let args = FormatRule.semicolons(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "semicolons",
			"--semicolons", "never"
		])
	}

	@Test
	private func `semicolons .enable mode .inline 展開 --semicolons inline`() {
		let args = FormatRule.semicolons(rule: .enable, mode: .inline).cliArguments
		#expect(args == [
			"--enable", "semicolons",
			"--semicolons", "inline"
		])
	}
}
