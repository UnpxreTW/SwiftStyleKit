//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantLetError")
private struct RedundantLetErrorTests {

	@Test
	private func `redundantLetError .disable 返空陣列`() {
		#expect(FormatRule.redundantLetError(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantLetError .enable 展開 --enable redundantLetError`() {
		let args = FormatRule.redundantLetError(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantLetError"])
	}
}
