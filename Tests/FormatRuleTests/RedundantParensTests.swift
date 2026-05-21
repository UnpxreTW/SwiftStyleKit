//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantParens")
struct RedundantParensTests {

	@Test("redundantParens .disable 返空陣列")
	func redundantParensDisable() {
		#expect(FormatRule.redundantParens(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantParens .enable 展開 --enable redundantParens")
	func redundantParensEnable() {
		let args = FormatRule.redundantParens(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantParens"])
	}
}
