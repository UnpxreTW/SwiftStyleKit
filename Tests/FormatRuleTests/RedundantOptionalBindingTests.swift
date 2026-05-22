//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantOptionalBinding")
struct RedundantOptionalBindingTests {

	@Test
	func `redundantOptionalBinding .disable 返空陣列`() {
		#expect(FormatRule.redundantOptionalBinding(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantOptionalBinding .enable 展開 --enable redundantOptionalBinding`() {
		let args = FormatRule.redundantOptionalBinding(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantOptionalBinding"])
	}
}
