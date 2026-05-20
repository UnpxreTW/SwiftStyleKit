//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantClosure")
struct RedundantClosureTests {

	@Test("redundantClosure .disable 返空陣列")
	func redundantClosureDisable() {
		#expect(FormatRule.redundantClosure(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantClosure .enable 展開 --enable redundantClosure")
	func redundantClosureEnable() {
		let args = FormatRule.redundantClosure(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantClosure"])
	}
}
