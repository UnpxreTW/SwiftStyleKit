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

	@Test
	func `redundantLet .disable 返空陣列`() {
		#expect(FormatRule.redundantLet(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantLet .enable 展開 --enable redundantLet`() {
		let args = FormatRule.redundantLet(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantLet"])
	}
}
