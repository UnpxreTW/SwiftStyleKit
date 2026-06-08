//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantInit")
private struct RedundantInitTests {

	@Test
	private func `redundantInit .disable 返空陣列`() {
		#expect(FormatRule.redundantInit(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantInit .enable 展開 --enable redundantInit`() {
		let args = FormatRule.redundantInit(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantInit"])
	}
}
