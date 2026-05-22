//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("strongifiedSelf")
struct StrongifiedSelfTests {

	@Test
	func `strongifiedSelf .disable 返空陣列`() {
		#expect(FormatRule.strongifiedSelf(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `strongifiedSelf .enable 展開 --enable strongifiedSelf`() {
		let args = FormatRule.strongifiedSelf(rule: .enable).cliArguments
		#expect(args == ["--enable", "strongifiedSelf"])
	}
}
