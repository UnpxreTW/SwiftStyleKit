//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("assertionFailures")
private struct AssertionFailuresTests {

	@Test
	private func `assertionFailures .disable 返空陣列`() {
		let args = FormatRule.assertionFailures(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `assertionFailures .enable 展開 --enable assertionFailures`() {
		let args = FormatRule.assertionFailures(.on).cliArguments
		#expect(args == ["--enable", "assertionFailures"])
	}
}
