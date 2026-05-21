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

	@Test("redundantStaticSelf .disable 返空陣列")
	func redundantStaticSelfDisable() {
		#expect(FormatRule.redundantStaticSelf(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantStaticSelf .enable 展開 --enable redundantStaticSelf")
	func redundantStaticSelfEnable() {
		let args = FormatRule.redundantStaticSelf(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantStaticSelf"])
	}
}
