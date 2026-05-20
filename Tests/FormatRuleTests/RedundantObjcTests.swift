//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantObjc")
struct RedundantObjcTests {

	@Test("redundantObjc .disable 返空陣列")
	func redundantObjcDisable() {
		#expect(FormatRule.redundantObjc(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantObjc .enable 展開 --enable redundantObjc")
	func redundantObjcEnable() {
		let args = FormatRule.redundantObjc(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantObjc"])
	}
}
