//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("sortImports")
struct SortImportsTests {

	@Test
	func `sortImports .disable 返空陣列`() {
		let args = FormatRule.sortImports(rule: .disable, mode: .alpha).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `sortImports .enable（預設 .testableFirst）展開 --enable + --importgrouping testable-first`() {
		let args = FormatRule.sortImports(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "sortImports",
			"--importgrouping", "testable-first"
		])
	}

	@Test
	func `sortImports .enable mode .alpha 展開 --importgrouping alpha`() {
		let args = FormatRule.sortImports(rule: .enable, mode: .alpha).cliArguments
		#expect(args == [
			"--enable", "sortImports",
			"--importgrouping", "alpha"
		])
	}

	@Test
	func `sortImports .enable mode .testableLast 展開 --importgrouping testable-last`() {
		let args = FormatRule.sortImports(rule: .enable, mode: .testableLast).cliArguments
		#expect(args == [
			"--enable", "sortImports",
			"--importgrouping", "testable-last"
		])
	}

	@Test
	func `sortImports .enable mode .length 展開 --importgrouping length`() {
		let args = FormatRule.sortImports(rule: .enable, mode: .length).cliArguments
		#expect(args == [
			"--enable", "sortImports",
			"--importgrouping", "length"
		])
	}
}
