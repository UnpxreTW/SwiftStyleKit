//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("validateTestCases")
private struct ValidateTestCasesTests {

	@Test
	private func `validateTestCases .disable 返空陣列`() {
		#expect(FormatRule.validateTestCases(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `validateTestCases .enable 只 enable 不展開 option`() {
		#expect(FormatRule.validateTestCases(rule: .enable).cliArguments == ["--enable", "validateTestCases"])
	}
}
