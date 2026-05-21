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

	@Test("strongifiedSelf .disable 返空陣列")
	func strongifiedSelfDisable() {
		#expect(FormatRule.strongifiedSelf(rule: .disable).cliArguments.isEmpty)
	}

	@Test("strongifiedSelf .enable 展開 --enable strongifiedSelf")
	func strongifiedSelfEnable() {
		let args = FormatRule.strongifiedSelf(rule: .enable).cliArguments
		#expect(args == ["--enable", "strongifiedSelf"])
	}
}
