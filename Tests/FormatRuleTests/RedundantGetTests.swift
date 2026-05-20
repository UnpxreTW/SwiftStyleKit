//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantGet")
struct RedundantGetTests {

	@Test("redundantGet .disable 返空陣列")
	func redundantGetDisable() {
		#expect(FormatRule.redundantGet(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantGet .enable 展開 --enable redundantGet")
	func redundantGetEnable() {
		let args = FormatRule.redundantGet(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantGet"])
	}
}
