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

	@Test("conditionalAssignment .disable 返空陣列")
	func conditionalAssignmentDisable() {
		let args = FormatRule.conditionalAssignment(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("conditionalAssignment .disable + mode（option 被忽略）返空陣列")
	func conditionalAssignmentDisableWithMode() {
		let args = FormatRule.conditionalAssignment(rule: .disable, mode: .afterProperty).cliArguments
		#expect(args.isEmpty)
	}

	@Test("conditionalAssignment .enable（mode 預設 .always）展開 --enable + --conditionalAssignment always")
	func conditionalAssignmentEnableDefault() {
		let args = FormatRule.conditionalAssignment(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "conditionalAssignment",
			"--conditionalAssignment", "always"
		])
	}

	@Test("conditionalAssignment .enable mode .afterProperty 展開 --conditionalAssignment after-property")
	func conditionalAssignmentEnableAfterProperty() {
		let args = FormatRule.conditionalAssignment(rule: .enable, mode: .afterProperty).cliArguments
		#expect(args == [
			"--enable", "conditionalAssignment",
			"--conditionalAssignment", "after-property"
		])
	}
}
