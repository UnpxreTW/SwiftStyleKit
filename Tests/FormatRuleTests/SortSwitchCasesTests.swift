//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("sortSwitchCases")
struct SortSwitchCasesTests {

	@Test
	func `sortSwitchCases .disable 返空陣列`() {
		#expect(FormatRule.sortSwitchCases(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `sortSwitchCases .enable 只 enable 不展開 option`() {
		#expect(FormatRule.sortSwitchCases(rule: .enable).cliArguments == ["--enable", "sortSwitchCases"])
	}
}
