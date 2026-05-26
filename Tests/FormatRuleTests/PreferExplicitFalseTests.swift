//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferExplicitFalse")
struct PreferExplicitFalseTests {

	@Test
	func `preferExplicitFalse .disable 返空陣列`() {
		#expect(FormatRule.preferExplicitFalse(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `preferExplicitFalse .enable 展開 --enable preferExplicitFalse`() {
		let args = FormatRule.preferExplicitFalse(rule: .enable).cliArguments
		#expect(args == ["--enable", "preferExplicitFalse"])
	}
}
