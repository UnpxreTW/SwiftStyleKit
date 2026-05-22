//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("andOperator")
struct AndOperatorTests {

	@Test
	func `andOperator .disable 返空陣列`() {
		let args = FormatRule.andOperator(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `andOperator .enable 展開 --enable andOperator`() {
		let args = FormatRule.andOperator(rule: .enable).cliArguments
		#expect(args == ["--enable", "andOperator"])
	}
}
