//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("sortImports")
private struct SortImportsTests {

	@Test
	private func `sortImports .disable 返空陣列`() {
		let args = FormatRule.sortImports(rule: .disable, mode: .alpha).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `sortImports .enable（預設 .testableFirst）展開 --enable + --importgrouping testable-first`() {
		let args = FormatRule.sortImports(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "sortImports",
			"--importgrouping", "testable-first"
		])
	}

	@Test
	private func `sortImports .enable mode .alpha 展開 --importgrouping alpha`() {
		let args = FormatRule.sortImports(rule: .enable, mode: .alpha).cliArguments
		#expect(args == [
			"--enable", "sortImports",
			"--importgrouping", "alpha"
		])
	}

	@Test
	private func `sortImports .enable mode .testableLast 展開 --importgrouping testable-last`() {
		let args = FormatRule.sortImports(rule: .enable, mode: .testableLast).cliArguments
		#expect(args == [
			"--enable", "sortImports",
			"--importgrouping", "testable-last"
		])
	}

	@Test
	private func `sortImports .enable mode .length 展開 --importgrouping length`() {
		let args = FormatRule.sortImports(rule: .enable, mode: .length).cliArguments
		#expect(args == [
			"--enable", "sortImports",
			"--importgrouping", "length"
		])
	}
}
