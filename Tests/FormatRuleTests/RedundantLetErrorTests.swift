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

	@Test
	func `redundantLetError .disable 返空陣列`() {
		#expect(FormatRule.redundantLetError(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantLetError .enable 展開 --enable redundantLetError`() {
		let args = FormatRule.redundantLetError(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantLetError"])
	}
}
