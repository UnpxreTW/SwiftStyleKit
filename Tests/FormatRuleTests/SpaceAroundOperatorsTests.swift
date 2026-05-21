//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceAroundOperators")
struct SpaceAroundOperatorsTests {

	@Test("spaceAroundOperators .disable 返空陣列")
	func spaceAroundOperatorsDisable() {
		#expect(FormatRule.spaceAroundOperators(rule: .disable).cliArguments.isEmpty)
	}

	@Test("spaceAroundOperators .enable 簽名預設展開 4 個 option（noSpaceOperators nil 不展開）")
	func spaceAroundOperatorsEnableDefault() {
		let args = FormatRule.spaceAroundOperators(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "spaceAroundOperators",
			"--operatorFunc", "no-space",
			"--ranges", "spaced",
			"--typeDelimiter", "space-after"
		])
	}

	@Test("spaceAroundOperators .enable + noSpaceOperators 空陣列等同 nil 不展開")
	func spaceAroundOperatorsEmptyNoSpaceOperators() {
		let args = FormatRule.spaceAroundOperators(
			rule: .enable,
			noSpaceOperators: []
		).cliArguments
		#expect(args == [
			"--enable", "spaceAroundOperators",
			"--operatorFunc", "no-space",
			"--ranges", "spaced",
			"--typeDelimiter", "space-after"
		])
	}

	@Test("spaceAroundOperators .enable + noSpaceOperators 有值展開逗號相連")
	func spaceAroundOperatorsWithNoSpaceOperators() {
		let args = FormatRule.spaceAroundOperators(
			rule: .enable,
			noSpaceOperators: ["..<", "..."]
		).cliArguments
		#expect(args == [
			"--enable", "spaceAroundOperators",
			"--operatorFunc", "no-space",
			"--ranges", "spaced",
			"--typeDelimiter", "space-after",
			"--noSpaceOperators", "..<,..."
		])
	}

	@Test("spaceAroundOperators .enable + 改 ranges 與 typeDelimiter")
	func spaceAroundOperatorsCustomModes() {
		let args = FormatRule.spaceAroundOperators(
			rule: .enable,
			operatorFunc: .insert,
			ranges: .remove,
			typeDelimiter: .spaced
		).cliArguments
		#expect(args == [
			"--enable", "spaceAroundOperators",
			"--operatorFunc", "spaced",
			"--ranges", "no-space",
			"--typeDelimiter", "spaced"
		])
	}
}
