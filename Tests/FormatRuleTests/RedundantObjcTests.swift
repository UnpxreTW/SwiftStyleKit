//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantObjc")
private struct RedundantObjcTests {

	@Test
	private func `redundantObjc .disable 返空陣列`() {
		#expect(FormatRule.redundantObjc(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantObjc .enable 展開 --enable redundantObjc`() {
		let args = FormatRule.redundantObjc(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantObjc"])
	}
}
