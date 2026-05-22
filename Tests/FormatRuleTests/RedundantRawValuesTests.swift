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

	@Test
	func `redundantRawValues .disable 返空陣列`() {
		#expect(FormatRule.redundantRawValues(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantRawValues .enable 展開 --enable redundantRawValues`() {
		let args = FormatRule.redundantRawValues(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantRawValues"])
	}
}
