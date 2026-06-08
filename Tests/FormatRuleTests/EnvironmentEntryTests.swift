//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("environmentEntry")
private struct EnvironmentEntryTests {

	@Test
	private func `environmentEntry .disable 返空陣列`() {
		let args = FormatRule.environmentEntry(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `environmentEntry .enable 展開 --enable environmentEntry`() {
		let args = FormatRule.environmentEntry(rule: .enable).cliArguments
		#expect(args == ["--enable", "environmentEntry"])
	}
}
