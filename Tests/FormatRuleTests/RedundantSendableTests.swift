//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantSendable")
struct RedundantSendableTests {

	@Test
	func `redundantSendable .disable 返空陣列`() {
		#expect(FormatRule.redundantSendable(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantSendable .enable 展開 --enable redundantSendable`() {
		let args = FormatRule.redundantSendable(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantSendable"])
	}
}
