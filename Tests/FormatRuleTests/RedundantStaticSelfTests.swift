//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantStaticSelf")
private struct RedundantStaticSelfTests {

	@Test
	private func `redundantStaticSelf .disable 返空陣列`() {
		#expect(FormatRule.redundantStaticSelf(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantStaticSelf .enable 展開 --enable redundantStaticSelf`() {
		let args = FormatRule.redundantStaticSelf(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantStaticSelf"])
	}
}
