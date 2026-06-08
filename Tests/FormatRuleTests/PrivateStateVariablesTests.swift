//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("privateStateVariables")
private struct PrivateStateVariablesTests {

	@Test
	private func `privateStateVariables .disable 返空陣列`() {
		#expect(FormatRule.privateStateVariables(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `privateStateVariables .enable 展開 --enable privateStateVariables`() {
		let args = FormatRule.privateStateVariables(rule: .enable).cliArguments
		#expect(args == ["--enable", "privateStateVariables"])
	}
}
