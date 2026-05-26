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
private struct DocCommentsTests {

	@Test
	private func `docComments .disable 返空陣列`() {
		let args = FormatRule.docComments(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `docComments .disable + mode（option 被忽略）返空陣列`() {
		let args = FormatRule.docComments(rule: .disable, mode: .preserve).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `docComments .enable（mode 預設 .beforeDeclarations）展開 --enable + --docComments before-declarations`() {
		let args = FormatRule.docComments(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "docComments",
			"--docComments", "before-declarations"
		])
	}

	@Test
	private func `docComments .enable mode .preserve 展開 --docComments preserve`() {
		let args = FormatRule.docComments(rule: .enable, mode: .preserve).cliArguments
		#expect(args == [
			"--enable", "docComments",
			"--docComments", "preserve"
		])
	}
}
