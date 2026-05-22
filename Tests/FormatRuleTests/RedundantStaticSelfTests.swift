//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantStaticSelf")
struct RedundantStaticSelfTests {

	@Test
	func `redundantStaticSelf .disable 返空陣列`() {
		#expect(FormatRule.redundantStaticSelf(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantStaticSelf .enable 展開 --enable redundantStaticSelf`() {
		let args = FormatRule.redundantStaticSelf(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantStaticSelf"])
	}
}
