//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("strongifiedSelf")
private struct StrongifiedSelfTests {

	@Test
	private func `strongifiedSelf .disable 返空陣列`() {
		#expect(FormatRule.strongifiedSelf(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `strongifiedSelf .enable 展開 --enable strongifiedSelf`() {
		let args = FormatRule.strongifiedSelf(rule: .enable).cliArguments
		#expect(args == ["--enable", "strongifiedSelf"])
	}
}
