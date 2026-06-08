//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("anyObjectProtocol")
private struct AnyObjectProtocolTests {

	@Test
	private func `anyObjectProtocol .disable 返空陣列`() {
		let args = FormatRule.anyObjectProtocol(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `anyObjectProtocol .enable 展開 --enable anyObjectProtocol`() {
		let args = FormatRule.anyObjectProtocol(rule: .enable).cliArguments
		#expect(args == ["--enable", "anyObjectProtocol"])
	}
}
