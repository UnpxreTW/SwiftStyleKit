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

	@Test
	func `redundantNilInit .disable 返空陣列`() {
		let args = FormatRule.redundantNilInit(rule: .disable, mode: .remove).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `redundantNilInit .enable（mode 預設 .remove）展開 --enable + --nilinit remove`() {
		let args = FormatRule.redundantNilInit(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "redundantNilInit",
			"--nilinit", "remove",
		])
	}

	@Test
	func `redundantNilInit .enable mode .insert 展開 --nilinit insert`() {
		let args = FormatRule.redundantNilInit(rule: .enable, mode: .insert).cliArguments
		#expect(args == [
			"--enable", "redundantNilInit",
			"--nilinit", "insert",
		])
	}
}
