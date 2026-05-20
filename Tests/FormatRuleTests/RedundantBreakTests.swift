//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantBreak")
struct RedundantBreakTests {

	@Test("redundantBreak .disable 返空陣列")
	func redundantBreakDisable() {
		#expect(FormatRule.redundantBreak(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantBreak .enable 展開 --enable redundantBreak")
	func redundantBreakEnable() {
		let args = FormatRule.redundantBreak(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantBreak"])
	}
}
