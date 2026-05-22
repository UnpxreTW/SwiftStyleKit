//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("sortTypealiases")
struct SortTypealiasesTests {

	@Test
	func `sortTypealiases .disable 返空陣列`() {
		#expect(FormatRule.sortTypealiases(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `sortTypealiases .enable 展開 --enable sortTypealiases`() {
		let args = FormatRule.sortTypealiases(rule: .enable).cliArguments
		#expect(args == ["--enable", "sortTypealiases"])
	}
}
