//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("conditionalAssignment")
private struct ConditionalAssignmentTests {

	@Test
	private func `conditionalAssignment .disable 返空陣列`() {
		let args = FormatRule.conditionalAssignment(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `conditionalAssignment .disable + mode（option 被忽略）返空陣列`() {
		let args = FormatRule.conditionalAssignment(rule: .disable, mode: .afterProperty).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `conditionalAssignment .enable（mode 預設 .always）展開 --enable + --conditionalAssignment always`() {
		let args = FormatRule.conditionalAssignment(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "conditionalAssignment",
			"--conditionalAssignment", "always"
		])
	}

	@Test
	private func `conditionalAssignment .enable mode .afterProperty 展開 --conditionalAssignment after-property`() {
		let args = FormatRule.conditionalAssignment(rule: .enable, mode: .afterProperty).cliArguments
		#expect(args == [
			"--enable", "conditionalAssignment",
			"--conditionalAssignment", "after-property"
		])
	}
}
