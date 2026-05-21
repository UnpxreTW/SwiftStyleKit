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

	@Test("sortTypealiases .disable 返空陣列")
	func sortTypealiasesDisable() {
		#expect(FormatRule.sortTypealiases(rule: .disable).cliArguments.isEmpty)
	}

	@Test("sortTypealiases .enable 展開 --enable sortTypealiases")
	func sortTypealiasesEnable() {
		let args = FormatRule.sortTypealiases(rule: .enable).cliArguments
		#expect(args == ["--enable", "sortTypealiases"])
	}
}
