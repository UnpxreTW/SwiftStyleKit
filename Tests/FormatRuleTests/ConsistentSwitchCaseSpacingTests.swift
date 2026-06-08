//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("consistentSwitchCaseSpacing")
private struct ConsistentSwitchCaseSpacingTests {

	@Test
	private func `consistentSwitchCaseSpacing .disable 返空陣列`() {
		let args = FormatRule.consistentSwitchCaseSpacing(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `consistentSwitchCaseSpacing .enable 展開 --enable consistentSwitchCaseSpacing`() {
		let args = FormatRule.consistentSwitchCaseSpacing(rule: .enable).cliArguments
		#expect(args == ["--enable", "consistentSwitchCaseSpacing"])
	}
}
