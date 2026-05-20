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

	@Test("redundantBackticks .disable 返空陣列")
	func redundantBackticksDisable() {
		#expect(FormatRule.redundantBackticks(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantBackticks .enable 展開 --enable redundantBackticks")
	func redundantBackticksEnable() {
		let args = FormatRule.redundantBackticks(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantBackticks"])
	}
}
