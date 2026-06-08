//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceAroundOperators")
private struct SpaceAroundOperatorsTests {

	@Test
	private func `spaceAroundOperators .disable 返空陣列`() {
		#expect(FormatRule.spaceAroundOperators(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `spaceAroundOperators .enable 簽名預設展開 4 個 option（noSpaceOperators nil 不展開）`() {
		let args = FormatRule.spaceAroundOperators(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "spaceAroundOperators",
			"--operatorFunc", "no-space",
			"--ranges", "spaced",
			"--typeDelimiter", "space-after"
		])
	}

	@Test
	private func `spaceAroundOperators .enable + noSpaceOperators 空陣列等同 nil 不展開`() {
		let args = FormatRule.spaceAroundOperators(
			rule: .enable,
			noSpaceOperators: []
		)
		.cliArguments
		#expect(args == [
			"--enable", "spaceAroundOperators",
			"--operatorFunc", "no-space",
			"--ranges", "spaced",
			"--typeDelimiter", "space-after"
		])
	}

	@Test
	private func `spaceAroundOperators .enable + noSpaceOperators 有值展開逗號相連`() {
		let args = FormatRule.spaceAroundOperators(
			rule: .enable,
			noSpaceOperators: ["..<", "..."]
		)
		.cliArguments
		#expect(args == [
			"--enable", "spaceAroundOperators",
			"--operatorFunc", "no-space",
			"--ranges", "spaced",
			"--typeDelimiter", "space-after",
			"--noSpaceOperators", "..<,..."
		])
	}

	@Test
	private func `spaceAroundOperators .enable + 改 ranges 與 typeDelimiter`() {
		let args = FormatRule.spaceAroundOperators(
			rule: .enable,
			operatorFunc: .insert,
			ranges: .remove,
			typeDelimiter: .spaced
		)
		.cliArguments
		#expect(args == [
			"--enable", "spaceAroundOperators",
			"--operatorFunc", "spaced",
			"--ranges", "no-space",
			"--typeDelimiter", "spaced"
		])
	}
}
