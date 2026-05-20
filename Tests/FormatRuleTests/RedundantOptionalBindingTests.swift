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

	@Test("redundantOptionalBinding .disable 返空陣列")
	func redundantOptionalBindingDisable() {
		#expect(FormatRule.redundantOptionalBinding(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantOptionalBinding .enable 展開 --enable redundantOptionalBinding")
	func redundantOptionalBindingEnable() {
		let args = FormatRule.redundantOptionalBinding(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantOptionalBinding"])
	}
}
