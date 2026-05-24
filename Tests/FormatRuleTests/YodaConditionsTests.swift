//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("yodaConditions")
struct YodaConditionsTests {

	@Test
	func `yodaConditions .disable 返空陣列`() {
		#expect(FormatRule.yodaConditions(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `yodaConditions .enable 簽名預設展開 --yodaSwap always`() {
		let args = FormatRule.yodaConditions(rule: .enable).cliArguments
		#expect(args == ["--enable", "yodaConditions", "--yodaSwap", "always"])
	}

	@Test
	func `yodaConditions .enable mode .literalsOnly 展開 --yodaSwap literals-only`() {
		let args = FormatRule.yodaConditions(rule: .enable, mode: .literalsOnly).cliArguments
		#expect(args == ["--enable", "yodaConditions", "--yodaSwap", "literals-only"])
	}
}
