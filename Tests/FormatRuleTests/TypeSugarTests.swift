//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("typeSugar")
struct TypeSugarTests {

	@Test
	func `typeSugar .disable 返空陣列`() {
		#expect(FormatRule.typeSugar(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `typeSugar .enable 簽名預設展開 --shortOptionals preserve-struct-inits`() {
		let args = FormatRule.typeSugar(rule: .enable).cliArguments
		#expect(args == ["--enable", "typeSugar", "--shortOptionals", "preserve-struct-inits"])
	}

	@Test
	func `typeSugar .enable mode .always 展開 --shortOptionals always`() {
		let args = FormatRule.typeSugar(rule: .enable, mode: .always).cliArguments
		#expect(args == ["--enable", "typeSugar", "--shortOptionals", "always"])
	}
}
