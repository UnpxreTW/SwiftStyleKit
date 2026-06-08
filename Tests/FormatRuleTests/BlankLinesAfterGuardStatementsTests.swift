//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesAfterGuardStatements")
private struct BlankLinesAfterGuardStatementsTests {

	@Test
	private func `blankLinesAfterGuardStatements .disable 返空陣列`() {
		#expect(FormatRule.blankLinesAfterGuardStatements(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `blankLinesAfterGuardStatements .enable 簽名預設展開 --lineBetweenGuards false`() {
		let args = FormatRule.blankLinesAfterGuardStatements(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "blankLinesAfterGuardStatements",
			"--lineBetweenGuards", "false"
		])
	}

	@Test
	private func `blankLinesAfterGuardStatements .enable lineBetweenGuards .enable 展開 true`() {
		let args = FormatRule.blankLinesAfterGuardStatements(
			rule: .enable,
			lineBetweenGuards: .enable
		)
		.cliArguments
		#expect(args == [
			"--enable", "blankLinesAfterGuardStatements",
			"--lineBetweenGuards", "true"
		])
	}
}
