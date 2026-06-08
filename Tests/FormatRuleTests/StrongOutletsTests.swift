//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("strongOutlets")
private struct StrongOutletsTests {

	@Test
	private func `strongOutlets .disable 返空陣列`() {
		#expect(FormatRule.strongOutlets(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `strongOutlets .enable 展開 --enable strongOutlets`() {
		let args = FormatRule.strongOutlets(rule: .enable).cliArguments
		#expect(args == ["--enable", "strongOutlets"])
	}
}
