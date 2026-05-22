//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("consistentSwitchCaseSpacing")
struct ConsistentSwitchCaseSpacingTests {

	@Test
	func `consistentSwitchCaseSpacing .disable 返空陣列`() {
		let args = FormatRule.consistentSwitchCaseSpacing(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `consistentSwitchCaseSpacing .enable 展開 --enable consistentSwitchCaseSpacing`() {
		let args = FormatRule.consistentSwitchCaseSpacing(rule: .enable).cliArguments
		#expect(args == ["--enable", "consistentSwitchCaseSpacing"])
	}
}
