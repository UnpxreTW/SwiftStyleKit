//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("todos")
struct TodosTests {

	@Test("todos .disable 返空陣列")
	func todosDisable() {
		#expect(FormatRule.todos(rule: .disable).cliArguments.isEmpty)
	}

	@Test("todos .enable 展開 --enable todos")
	func todosEnable() {
		let args = FormatRule.todos(rule: .enable).cliArguments
		#expect(args == ["--enable", "todos"])
	}
}
