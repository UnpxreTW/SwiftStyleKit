//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("conditionalAssignment")
struct ConditionalAssignmentTests {

	@Test
	func `conditionalAssignment .disable 返空陣列`() {
		let args = FormatRule.conditionalAssignment(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `conditionalAssignment .disable + mode（option 被忽略）返空陣列`() {
		let args = FormatRule.conditionalAssignment(rule: .disable, mode: .afterProperty).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `conditionalAssignment .enable（mode 預設 .always）展開 --enable + --conditionalAssignment always`() {
		let args = FormatRule.conditionalAssignment(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "conditionalAssignment",
			"--conditionalAssignment", "always"
		])
	}

	@Test
	func `conditionalAssignment .enable mode .afterProperty 展開 --conditionalAssignment after-property`() {
		let args = FormatRule.conditionalAssignment(rule: .enable, mode: .afterProperty).cliArguments
		#expect(args == [
			"--enable", "conditionalAssignment",
			"--conditionalAssignment", "after-property"
		])
	}
}
