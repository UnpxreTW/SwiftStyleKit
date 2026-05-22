//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("assertionFailures")
struct AssertionFailuresTests {

	@Test
	func `assertionFailures .disable 返空陣列`() {
		let args = FormatRule.assertionFailures(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `assertionFailures .enable 展開 --enable assertionFailures`() {
		let args = FormatRule.assertionFailures(rule: .enable).cliArguments
		#expect(args == ["--enable", "assertionFailures"])
	}
}
