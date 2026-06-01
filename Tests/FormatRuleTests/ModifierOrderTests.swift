//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("modifierOrder")
private struct ModifierOrderTests {

	@Test
	private func `modifierOrder .disable 返空陣列`() {
		let args = FormatRule.modifierOrder(rule: .disable, modifierOrder: "public,static").cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `modifierOrder .enable（modifierOrder 預設 nil）只展開 --enable`() {
		let args = FormatRule.modifierOrder(rule: .enable).cliArguments
		#expect(args == ["--enable", "modifierOrder"])
	}

	@Test
	private func `modifierOrder .enable modifierOrder 有值展開 --modifierOrder`() {
		let args = FormatRule.modifierOrder(rule: .enable, modifierOrder: "public,static").cliArguments
		#expect(args == [
			"--enable", "modifierOrder",
			"--modifierOrder", "public,static"
		])
	}
}
