//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesAfterGuardStatements")
struct BlankLinesAfterGuardStatementsTests {

	@Test
	func `blankLinesAfterGuardStatements .disable 返空陣列`() {
		#expect(FormatRule.blankLinesAfterGuardStatements(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `blankLinesAfterGuardStatements .enable 簽名預設展開 --lineBetweenGuards false`() {
		let args = FormatRule.blankLinesAfterGuardStatements(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "blankLinesAfterGuardStatements",
			"--lineBetweenGuards", "false"
		])
	}

	@Test
	func `blankLinesAfterGuardStatements .enable lineBetweenGuards .enable 展開 true`() {
		let args = FormatRule.blankLinesAfterGuardStatements(
			rule: .enable,
			lineBetweenGuards: .enable
		).cliArguments
		#expect(args == [
			"--enable", "blankLinesAfterGuardStatements",
			"--lineBetweenGuards", "true"
		])
	}
}
