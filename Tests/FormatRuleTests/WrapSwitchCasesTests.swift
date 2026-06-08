//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapSwitchCases")
private struct WrapSwitchCasesTests {

	@Test
	private func `wrapSwitchCases .disable 返空陣列`() {
		#expect(FormatRule.wrapSwitchCases(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapSwitchCases .enable 只 enable 不展開 option`() {
		#expect(FormatRule.wrapSwitchCases(rule: .enable).cliArguments == ["--enable", "wrapSwitchCases"])
	}
}
