//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("andOperator")
private struct AndOperatorTests {

	@Test
	private func `andOperator .disable 返空陣列`() {
		let args = FormatRule.andOperator(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `andOperator .enable 展開 --enable andOperator`() {
		let args = FormatRule.andOperator(.on).cliArguments
		#expect(args == ["--enable", "andOperator"])
	}
}
