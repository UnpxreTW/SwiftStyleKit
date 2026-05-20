//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantLetError")
struct RedundantLetErrorTests {

	@Test("redundantLetError .disable 返空陣列")
	func redundantLetErrorDisable() {
		#expect(FormatRule.redundantLetError(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantLetError .enable 展開 --enable redundantLetError")
	func redundantLetErrorEnable() {
		let args = FormatRule.redundantLetError(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantLetError"])
	}
}
