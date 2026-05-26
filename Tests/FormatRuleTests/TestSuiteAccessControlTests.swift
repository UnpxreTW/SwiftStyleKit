//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("testSuiteAccessControl")
private struct TestSuiteAccessControlTests {

	@Test
	private func `testSuiteAccessControl .disable 返空陣列`() {
		#expect(FormatRule.testSuiteAccessControl(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `testSuiteAccessControl .enable 簽名預設展開 private`() {
		#expect(FormatRule.testSuiteAccessControl(rule: .enable).cliArguments == [
			"--enable", "testSuiteAccessControl",
			"--testCaseAccessControl", "private"
		])
	}

	@Test
	private func `testSuiteAccessControl .enable .internal 展開`() {
		let args = FormatRule.testSuiteAccessControl(rule: .enable, testCaseAccessControl: .internal).cliArguments
		#expect(args.contains("--testCaseAccessControl"))
		#expect(args.contains("internal"))
	}

	@Test
	private func `testSuiteAccessControl .enable .fileprivate 展開`() {
		let args = FormatRule.testSuiteAccessControl(rule: .enable, testCaseAccessControl: .fileprivate).cliArguments
		#expect(args.contains("fileprivate"))
	}
}
