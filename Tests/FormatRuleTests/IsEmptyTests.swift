//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("isEmpty")
private struct IsEmptyTests {

	@Test
	private func `isEmpty .disable 返空陣列`() {
		#expect(FormatRule.isEmpty(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `isEmpty .enable 展開 --enable isEmpty`() {
		let args = FormatRule.isEmpty(rule: .enable).cliArguments
		#expect(args == ["--enable", "isEmpty"])
	}
}
