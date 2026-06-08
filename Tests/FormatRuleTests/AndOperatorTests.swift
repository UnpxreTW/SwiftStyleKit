//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("andOperator")
private struct AndOperatorTests {

	@Test
	private func `andOperator .disable 返空陣列`() {
		let args = FormatRule.andOperator(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `andOperator .enable 展開 --enable andOperator`() {
		let args = FormatRule.andOperator(rule: .enable).cliArguments
		#expect(args == ["--enable", "andOperator"])
	}
}
