//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantInit")
struct RedundantInitTests {

	@Test("redundantInit .disable 返空陣列")
	func redundantInitDisable() {
		#expect(FormatRule.redundantInit(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantInit .enable 展開 --enable redundantInit")
	func redundantInitEnable() {
		let args = FormatRule.redundantInit(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantInit"])
	}
}
