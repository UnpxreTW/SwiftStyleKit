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

	@Test
	func `leadingDelimiters .disable 返空陣列`() {
		#expect(FormatRule.leadingDelimiters(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `leadingDelimiters .enable 展開 --enable leadingDelimiters`() {
		#expect(FormatRule.leadingDelimiters(rule: .enable).cliArguments == ["--enable", "leadingDelimiters"])
	}
}
