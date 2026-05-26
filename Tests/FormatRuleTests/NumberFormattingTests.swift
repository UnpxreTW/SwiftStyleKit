//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("numberFormatting")
private struct NumberFormattingTests {

	@Test
	private func `numberFormatting .disable 返空陣列`() {
		#expect(FormatRule.numberFormatting(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `numberFormatting .enable 預設值展開全部 8 個 option`() {
		let args = FormatRule.numberFormatting(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "numberFormatting",
			"--decimalGrouping", "3,5",
			"--binaryGrouping", "4,4",
			"--octalGrouping", "4,4",
			"--hexGrouping", "4,4",
			"--fractionGrouping", "true",
			"--exponentGrouping", "false",
			"--hexLiteralCase", "uppercase",
			"--exponentCase", "lowercase"
		])
	}

	@Test
	private func `numberFormatting grouping 設 nil 則不展開該 flag`() {
		let args = FormatRule.numberFormatting(rule: .enable, decimalGrouping: nil).cliArguments
		#expect(!args.contains("--decimalGrouping"))
		#expect(args.contains("--binaryGrouping"))
	}
}
