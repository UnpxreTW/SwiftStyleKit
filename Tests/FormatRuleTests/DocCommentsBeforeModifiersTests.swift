//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("docCommentsBeforeModifiers")
private struct DocCommentsBeforeModifiersTests {

	@Test
	private func `docCommentsBeforeModifiers .disable 返空陣列`() {
		let args = FormatRule.docCommentsBeforeModifiers(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `docCommentsBeforeModifiers .enable 展開 --enable docCommentsBeforeModifiers`() {
		let args = FormatRule.docCommentsBeforeModifiers(rule: .enable).cliArguments
		#expect(args == ["--enable", "docCommentsBeforeModifiers"])
	}
}
