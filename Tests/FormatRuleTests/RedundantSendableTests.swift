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
private struct RedundantSendableTests {

	@Test
	private func `redundantSendable .disable 返空陣列`() {
		#expect(FormatRule.redundantSendable(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantSendable .enable 展開 --enable redundantSendable`() {
		let args = FormatRule.redundantSendable(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantSendable"])
	}
}
