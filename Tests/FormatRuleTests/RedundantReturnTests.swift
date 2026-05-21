//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantReturn")
struct RedundantReturnTests {

	@Test("redundantReturn .disable 返空陣列")
	func redundantReturnDisable() {
		#expect(FormatRule.redundantReturn(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantReturn .enable 展開 --enable redundantReturn")
	func redundantReturnEnable() {
		let args = FormatRule.redundantReturn(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantReturn"])
	}
}
