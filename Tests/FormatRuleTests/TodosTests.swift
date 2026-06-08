//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("todos")
private struct TodosTests {

	@Test
	private func `todos .disable 返空陣列`() {
		#expect(FormatRule.todos(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `todos .enable 展開 --enable todos`() {
		let args = FormatRule.todos(rule: .enable).cliArguments
		#expect(args == ["--enable", "todos"])
	}
}
