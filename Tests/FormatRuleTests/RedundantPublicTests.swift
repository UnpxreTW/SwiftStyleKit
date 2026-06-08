//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantPublic")
private struct RedundantPublicTests {

	@Test
	private func `redundantPublic .disable 返空陣列`() {
		#expect(FormatRule.redundantPublic(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantPublic .enable 展開 --enable redundantPublic`() {
		let args = FormatRule.redundantPublic(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantPublic"])
	}
}
