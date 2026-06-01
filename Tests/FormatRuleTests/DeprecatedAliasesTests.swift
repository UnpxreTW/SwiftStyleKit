//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("deprecated aliases")
private struct DeprecatedAliasesTests {

	@available(*, deprecated)
	@Test
	private func `sortedImports 展開仍用舊 flag 名`() {
		#expect(FormatRule.sortedImports(rule: .enable).cliArguments == [
			"--enable", "sortedImports",
			"--importgrouping", "testable-first"
		])
	}

	@available(*, deprecated)
	@Test
	private func `sortedSwitchCases 展開仍用舊 flag 名`() {
		#expect(FormatRule.sortedSwitchCases(rule: .enable).cliArguments == ["--enable", "sortedSwitchCases"])
	}

	@available(*, deprecated)
	@Test
	private func `specifiers 展開仍用舊 flag 名`() {
		#expect(FormatRule.specifiers(rule: .enable).cliArguments == ["--enable", "specifiers"])
	}

	@available(*, deprecated)
	@Test
	private func `throwingTests 展開仍用舊 flag 名`() {
		#expect(FormatRule.throwingTests(rule: .enable).cliArguments == ["--enable", "throwingTests"])
	}

	@available(*, deprecated)
	@Test
	private func `redundantProperty 展開仍用舊 flag 名`() {
		#expect(FormatRule.redundantProperty(rule: .enable).cliArguments == ["--enable", "redundantProperty"])
	}

	@available(*, deprecated)
	@Test
	private func `deprecated 別名 .disable 都返空陣列`() {
		#expect(FormatRule.sortedImports(rule: .disable).cliArguments.isEmpty)
		#expect(FormatRule.sortedSwitchCases(rule: .disable).cliArguments.isEmpty)
		#expect(FormatRule.specifiers(rule: .disable).cliArguments.isEmpty)
		#expect(FormatRule.throwingTests(rule: .disable).cliArguments.isEmpty)
		#expect(FormatRule.redundantProperty(rule: .disable).cliArguments.isEmpty)
	}
}
