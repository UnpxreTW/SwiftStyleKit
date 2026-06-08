//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferExplicitFalse")
private struct PreferExplicitFalseTests {

	@Test
	private func `preferExplicitFalse .disable 返空陣列`() {
		#expect(FormatRule.preferExplicitFalse(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `preferExplicitFalse .enable 展開 --enable preferExplicitFalse`() {
		let args = FormatRule.preferExplicitFalse(rule: .enable).cliArguments
		#expect(args == ["--enable", "preferExplicitFalse"])
	}
}
