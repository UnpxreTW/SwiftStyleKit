//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantNilInit")
struct RedundantNilInitTests {

	@Test("redundantNilInit .disable 返空陣列")
	func redundantNilInitDisable() {
		let args = FormatRule.redundantNilInit(rule: .disable, mode: .remove).cliArguments
		#expect(args.isEmpty)
	}

	@Test("redundantNilInit .enable（mode 預設 .remove）展開 --enable + --nilinit remove")
	func redundantNilInitEnableDefault() {
		let args = FormatRule.redundantNilInit(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "redundantNilInit",
			"--nilinit", "remove"
		])
	}

	@Test("redundantNilInit .enable mode .insert 展開 --nilinit insert")
	func redundantNilInitEnableInsert() {
		let args = FormatRule.redundantNilInit(rule: .enable, mode: .insert).cliArguments
		#expect(args == [
			"--enable", "redundantNilInit",
			"--nilinit", "insert"
		])
	}
}
