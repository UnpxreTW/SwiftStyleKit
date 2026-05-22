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

	@Test
	func `redundantInit .disable 返空陣列`() {
		#expect(FormatRule.redundantInit(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantInit .enable 展開 --enable redundantInit`() {
		let args = FormatRule.redundantInit(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantInit"])
	}
}
