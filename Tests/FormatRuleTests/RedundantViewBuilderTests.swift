//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantViewBuilder")
private struct RedundantViewBuilderTests {

	@Test
	private func `redundantViewBuilder .disable 返空陣列`() {
		#expect(FormatRule.redundantViewBuilder(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantViewBuilder .enable 展開 --enable redundantViewBuilder`() {
		let args = FormatRule.redundantViewBuilder(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantViewBuilder"])
	}
}
