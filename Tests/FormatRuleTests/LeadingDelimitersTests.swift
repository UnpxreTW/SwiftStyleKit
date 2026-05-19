//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("leadingDelimiters")
struct LeadingDelimitersTests {

	@Test("leadingDelimiters .disable 返空陣列")
	func leadingDelimitersDisable() {
		#expect(FormatRule.leadingDelimiters(rule: .disable).cliArguments.isEmpty)
	}

	@Test("leadingDelimiters .enable 展開 --enable leadingDelimiters")
	func leadingDelimitersEnable() {
		#expect(FormatRule.leadingDelimiters(rule: .enable).cliArguments == ["--enable", "leadingDelimiters"])
	}
}
