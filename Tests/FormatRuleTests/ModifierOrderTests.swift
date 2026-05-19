//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("modifierOrder")
struct ModifierOrderTests {

	@Test("modifierOrder .disable 返空陣列")
	func modifierOrderDisable() {
		let args = FormatRule.modifierOrder(rule: .disable, modifierOrder: "public,static").cliArguments
		#expect(args.isEmpty)
	}

	@Test("modifierOrder .enable（modifierOrder 預設 nil）只展開 --enable")
	func modifierOrderEnableDefault() {
		let args = FormatRule.modifierOrder(rule: .enable).cliArguments
		#expect(args == ["--enable", "modifierOrder"])
	}

	@Test("modifierOrder .enable modifierOrder 有值展開 --modifierOrder")
	func modifierOrderEnableWithList() {
		let args = FormatRule.modifierOrder(rule: .enable, modifierOrder: "public,static").cliArguments
		#expect(args == [
			"--enable", "modifierOrder",
			"--modifierOrder", "public,static"
		])
	}
}
