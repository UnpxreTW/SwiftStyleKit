//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantInternal")
struct RedundantInternalTests {

	@Test("redundantInternal .disable 返空陣列")
	func redundantInternalDisable() {
		#expect(FormatRule.redundantInternal(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantInternal .enable 展開 --enable redundantInternal")
	func redundantInternalEnable() {
		let args = FormatRule.redundantInternal(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantInternal"])
	}
}
