//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantTypedThrows")
struct RedundantTypedThrowsTests {

	@Test
	func `redundantTypedThrows .disable 返空陣列`() {
		#expect(FormatRule.redundantTypedThrows(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantTypedThrows .enable 展開 --enable redundantTypedThrows`() {
		let args = FormatRule.redundantTypedThrows(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantTypedThrows"])
	}
}
