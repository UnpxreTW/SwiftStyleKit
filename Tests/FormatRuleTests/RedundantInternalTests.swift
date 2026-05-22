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

	@Test
	func `redundantInternal .disable 返空陣列`() {
		#expect(FormatRule.redundantInternal(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantInternal .enable 展開 --enable redundantInternal`() {
		let args = FormatRule.redundantInternal(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantInternal"])
	}
}
