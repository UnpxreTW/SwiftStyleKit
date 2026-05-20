//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantLet")
struct RedundantLetTests {

	@Test("redundantLet .disable 返空陣列")
	func redundantLetDisable() {
		#expect(FormatRule.redundantLet(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantLet .enable 展開 --enable redundantLet")
	func redundantLetEnable() {
		let args = FormatRule.redundantLet(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantLet"])
	}
}
