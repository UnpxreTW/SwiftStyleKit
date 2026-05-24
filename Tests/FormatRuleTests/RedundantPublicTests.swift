//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantPublic")
struct RedundantPublicTests {

	@Test
	func `redundantPublic .disable 返空陣列`() {
		#expect(FormatRule.redundantPublic(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantPublic .enable 展開 --enable redundantPublic`() {
		let args = FormatRule.redundantPublic(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantPublic"])
	}
}
