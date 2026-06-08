//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("unusedArguments")
private struct UnusedArgumentsTests {

	@Test
	private func `unusedArguments .disable 返空陣列`() {
		#expect(FormatRule.unusedArguments(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `unusedArguments .enable 簽名預設展開 --stripUnusedArgs closure-only`() {
		let args = FormatRule.unusedArguments(rule: .enable).cliArguments
		#expect(args == ["--enable", "unusedArguments", "--stripUnusedArgs", "closure-only"])
	}

	@Test
	private func `unusedArguments .enable mode .all 展開 --stripUnusedArgs always`() {
		let args = FormatRule.unusedArguments(rule: .enable, mode: .all).cliArguments
		#expect(args == ["--enable", "unusedArguments", "--stripUnusedArgs", "always"])
	}

	@Test
	private func `unusedArguments .enable mode .unnamedOnly 展開 --stripUnusedArgs unnamed-only`() {
		let args = FormatRule.unusedArguments(rule: .enable, mode: .unnamedOnly).cliArguments
		#expect(args == ["--enable", "unusedArguments", "--stripUnusedArgs", "unnamed-only"])
	}
}
