//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantFileprivate")
struct RedundantFileprivateTests {

	@Test("redundantFileprivate .disable 返空陣列")
	func redundantFileprivateDisable() {
		#expect(FormatRule.redundantFileprivate(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantFileprivate .enable 展開 --enable redundantFileprivate")
	func redundantFileprivateEnable() {
		let args = FormatRule.redundantFileprivate(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantFileprivate"])
	}
}
