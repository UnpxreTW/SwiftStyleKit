//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("yodaConditions")
private struct YodaConditionsTests {

	@Test
	private func `yodaConditions .disable 返空陣列`() {
		#expect(FormatRule.yodaConditions(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `yodaConditions .enable 簽名預設展開 --yodaSwap always`() {
		let args = FormatRule.yodaConditions(rule: .enable).cliArguments
		#expect(args == ["--enable", "yodaConditions", "--yodaSwap", "always"])
	}

	@Test
	private func `yodaConditions .enable mode .literalsOnly 展開 --yodaSwap literals-only`() {
		let args = FormatRule.yodaConditions(rule: .enable, mode: .literalsOnly).cliArguments
		#expect(args == ["--enable", "yodaConditions", "--yodaSwap", "literals-only"])
	}
}
