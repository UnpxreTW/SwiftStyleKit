//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantOptionalBinding")
private struct RedundantOptionalBindingTests {

	@Test
	private func `redundantOptionalBinding .disable 返空陣列`() {
		#expect(FormatRule.redundantOptionalBinding(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantOptionalBinding .enable 展開 --enable redundantOptionalBinding`() {
		let args = FormatRule.redundantOptionalBinding(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantOptionalBinding"])
	}
}
