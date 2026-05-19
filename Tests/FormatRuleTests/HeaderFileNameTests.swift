//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("headerFileName")
struct HeaderFileNameTests {

	@Test("headerFileName .disable 返空陣列")
	func headerFileNameDisable() {
		#expect(FormatRule.headerFileName(rule: .disable).cliArguments.isEmpty)
	}

	@Test("headerFileName .enable 展開 --enable headerFileName")
	func headerFileNameEnable() {
		#expect(FormatRule.headerFileName(rule: .enable).cliArguments == ["--enable", "headerFileName"])
	}
}
