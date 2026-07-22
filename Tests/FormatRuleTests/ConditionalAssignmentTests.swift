//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("conditionalAssignment")
private struct ConditionalAssignmentTests {

	@Test
	private func `conditionalAssignment .disable 返空陣列`() {
		let args = FormatRule.conditionalAssignment(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `conditionalAssignment .enable（mode 預設 .always）展開 --enable + --conditionalAssignment always`() {
		let args = FormatRule.conditionalAssignment(.on).cliArguments
		#expect(args == [
			"--enable", "conditionalAssignment",
			"--conditionalAssignment", "always"
		])
	}

	@Test
	private func `conditionalAssignment .enable mode .afterProperty 展開 --conditionalAssignment after-property`() {
		let args = FormatRule.conditionalAssignment(.on, mode: .afterProperty).cliArguments
		#expect(args == [
			"--enable", "conditionalAssignment",
			"--conditionalAssignment", "after-property"
		])
	}
}
