//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("urlMacro")
private struct URLMacroTests {

	@Test
	private func `urlMacro .disable 返空陣列`() {
		#expect(FormatRule.urlMacro(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `urlMacro .enable 簽名預設 nil 不展開 option`() {
		#expect(FormatRule.urlMacro(rule: .enable).cliArguments == ["--enable", "urlMacro"])
	}

	@Test
	private func `urlMacro .enable 自訂 macro 名展開`() {
		let args = FormatRule.urlMacro(rule: .enable, urlMacro: "#URL,URLFoundation").cliArguments
		#expect(args.contains("--urlMacro"))
		#expect(args.contains("#URL,URLFoundation"))
	}
}
