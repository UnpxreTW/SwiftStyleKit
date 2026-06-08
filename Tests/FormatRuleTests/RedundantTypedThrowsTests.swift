//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantTypedThrows")
private struct RedundantTypedThrowsTests {

	@Test
	private func `redundantTypedThrows .disable 返空陣列`() {
		#expect(FormatRule.redundantTypedThrows(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantTypedThrows .enable 展開 --enable redundantTypedThrows`() {
		let args = FormatRule.redundantTypedThrows(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantTypedThrows"])
	}
}
