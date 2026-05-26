//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantSwiftTestingSuite")
private struct RedundantSwiftTestingSuiteTests {

	@Test
	private func `redundantSwiftTestingSuite .disable 返空陣列`() {
		#expect(FormatRule.redundantSwiftTestingSuite(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantSwiftTestingSuite .enable 展開 --enable redundantSwiftTestingSuite`() {
		let args = FormatRule.redundantSwiftTestingSuite(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantSwiftTestingSuite"])
	}
}
