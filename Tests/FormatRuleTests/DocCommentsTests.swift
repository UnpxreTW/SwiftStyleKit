//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("docComments")
struct DocCommentsTests {

	@Test("docComments .disable 返空陣列")
	func docCommentsDisable() {
		let args = FormatRule.docComments(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("docComments .disable + mode（option 被忽略）返空陣列")
	func docCommentsDisableWithMode() {
		let args = FormatRule.docComments(rule: .disable, mode: .preserve).cliArguments
		#expect(args.isEmpty)
	}

	@Test("docComments .enable（mode 預設 .beforeDeclarations）展開 --enable + --docComments before-declarations")
	func docCommentsEnableDefault() {
		let args = FormatRule.docComments(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "docComments",
			"--docComments", "before-declarations"
		])
	}

	@Test("docComments .enable mode .preserve 展開 --docComments preserve")
	func docCommentsEnablePreserve() {
		let args = FormatRule.docComments(rule: .enable, mode: .preserve).cliArguments
		#expect(args == [
			"--enable", "docComments",
			"--docComments", "preserve"
		])
	}
}
