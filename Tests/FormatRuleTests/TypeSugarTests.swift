//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("typeSugar")
private struct TypeSugarTests {

	@Test
	private func `typeSugar .disable 返空陣列`() {
		#expect(FormatRule.typeSugar(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `typeSugar .enable 簽名預設展開 --shortOptionals preserve-struct-inits`() {
		let args = FormatRule.typeSugar(rule: .enable).cliArguments
		#expect(args == ["--enable", "typeSugar", "--shortOptionals", "preserve-struct-inits"])
	}

	@Test
	private func `typeSugar .enable mode .always 展開 --shortOptionals always`() {
		let args = FormatRule.typeSugar(rule: .enable, mode: .always).cliArguments
		#expect(args == ["--enable", "typeSugar", "--shortOptionals", "always"])
	}
}
