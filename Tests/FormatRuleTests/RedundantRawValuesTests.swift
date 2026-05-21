//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantRawValues")
struct RedundantRawValuesTests {

	@Test("redundantRawValues .disable 返空陣列")
	func redundantRawValuesDisable() {
		#expect(FormatRule.redundantRawValues(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantRawValues .enable 展開 --enable redundantRawValues")
	func redundantRawValuesEnable() {
		let args = FormatRule.redundantRawValues(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantRawValues"])
	}
}
