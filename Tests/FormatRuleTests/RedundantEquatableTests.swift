//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantEquatable")
private struct RedundantEquatableTests {

	@Test
	private func `redundantEquatable .disable 返空陣列`() {
		let args = FormatRule.redundantEquatable(rule: .disable, equatableMacro: "@Eq,EqLib").cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `redundantEquatable .enable（equatableMacro 預設 nil）只展開 --enable`() {
		let args = FormatRule.redundantEquatable(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantEquatable"])
	}

	@Test
	private func `redundantEquatable .enable equatableMacro 有值展開 --equatableMacro`() {
		let args = FormatRule.redundantEquatable(rule: .enable, equatableMacro: "@Equatable,EquatableMacroLib").cliArguments
		#expect(args == [
			"--enable", "redundantEquatable",
			"--equatableMacro", "@Equatable,EquatableMacroLib"
		])
	}
}
