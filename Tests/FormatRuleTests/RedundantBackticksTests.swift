//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantBackticks")
private struct RedundantBackticksTests {

	@Test
	private func `redundantBackticks .disable 返空陣列`() {
		#expect(FormatRule.redundantBackticks(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantBackticks .enable 展開 --enable redundantBackticks`() {
		let args = FormatRule.redundantBackticks(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantBackticks"])
	}
}
