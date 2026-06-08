//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("noGuardInTests")
private struct NoGuardInTestsTests {

	@Test
	private func `noGuardInTests .disable 返空陣列`() {
		#expect(FormatRule.noGuardInTests(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `noGuardInTests .enable 展開 --enable noGuardInTests`() {
		let args = FormatRule.noGuardInTests(rule: .enable).cliArguments
		#expect(args == ["--enable", "noGuardInTests"])
	}
}
