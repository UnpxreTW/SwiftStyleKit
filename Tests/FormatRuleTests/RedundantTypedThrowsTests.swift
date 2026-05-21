//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantTypedThrows")
struct RedundantTypedThrowsTests {

	@Test("redundantTypedThrows .disable 返空陣列")
	func redundantTypedThrowsDisable() {
		#expect(FormatRule.redundantTypedThrows(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantTypedThrows .enable 展開 --enable redundantTypedThrows")
	func redundantTypedThrowsEnable() {
		let args = FormatRule.redundantTypedThrows(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantTypedThrows"])
	}
}
