//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("swiftTestingTestCaseNames")
struct SwiftTestingTestCaseNamesTests {

	@Test
	func `swiftTestingTestCaseNames .disable 返空陣列`() {
		#expect(FormatRule.swiftTestingTestCaseNames(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `swiftTestingTestCaseNames .enable 簽名預設展開 testCaseNameFormat=raw-identifiers suiteNameFormat=preserve`() {
		let args = FormatRule.swiftTestingTestCaseNames(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "swiftTestingTestCaseNames",
			"--testCaseNameFormat", "raw-identifiers",
			"--suiteNameFormat", "preserve",
		])
	}

	@Test
	func `swiftTestingTestCaseNames .enable + 改 suiteNameFormat 為 .rawIdentifiers`() {
		let args = FormatRule.swiftTestingTestCaseNames(
			rule: .enable,
			suiteNameFormat: .rawIdentifiers
		).cliArguments
		#expect(args == [
			"--enable", "swiftTestingTestCaseNames",
			"--testCaseNameFormat", "raw-identifiers",
			"--suiteNameFormat", "raw-identifiers",
		])
	}

	@Test
	func `swiftTestingTestCaseNames .enable + 兩個都 .standardIdentifiers`() {
		let args = FormatRule.swiftTestingTestCaseNames(
			rule: .enable,
			testCaseNameFormat: .standardIdentifiers,
			suiteNameFormat: .standardIdentifiers
		).cliArguments
		#expect(args == [
			"--enable", "swiftTestingTestCaseNames",
			"--testCaseNameFormat", "standard-identifiers",
			"--suiteNameFormat", "standard-identifiers",
		])
	}
}
