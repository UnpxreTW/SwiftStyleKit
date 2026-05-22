//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantBackticks")
struct RedundantBackticksTests {

	@Test
	func `redundantBackticks .disable 返空陣列`() {
		#expect(FormatRule.redundantBackticks(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantBackticks .enable 展開 --enable redundantBackticks`() {
		let args = FormatRule.redundantBackticks(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantBackticks"])
	}
}
