//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantEquatable")
struct RedundantEquatableTests {

	@Test
	func `redundantEquatable .disable 返空陣列`() {
		let args = FormatRule.redundantEquatable(rule: .disable, equatableMacro: "@Eq,EqLib").cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `redundantEquatable .enable（equatableMacro 預設 nil）只展開 --enable`() {
		let args = FormatRule.redundantEquatable(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantEquatable"])
	}

	@Test
	func `redundantEquatable .enable equatableMacro 有值展開 --equatableMacro`() {
		let args = FormatRule.redundantEquatable(rule: .enable, equatableMacro: "@Equatable,EquatableMacroLib").cliArguments
		#expect(args == [
			"--enable", "redundantEquatable",
			"--equatableMacro", "@Equatable,EquatableMacroLib",
		])
	}
}
