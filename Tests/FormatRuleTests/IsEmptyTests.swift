//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("isEmpty")
struct IsEmptyTests {

	@Test
	func `isEmpty .disable 返空陣列`() {
		#expect(FormatRule.isEmpty(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `isEmpty .enable 展開 --enable isEmpty`() {
		let args = FormatRule.isEmpty(rule: .enable).cliArguments
		#expect(args == ["--enable", "isEmpty"])
	}
}
