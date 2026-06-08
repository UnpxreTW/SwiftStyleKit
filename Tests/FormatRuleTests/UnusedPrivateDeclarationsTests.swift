//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("unusedPrivateDeclarations")
private struct UnusedPrivateDeclarationsTests {

	@Test
	private func `unusedPrivateDeclarations .disable 返空陣列`() {
		#expect(FormatRule.unusedPrivateDeclarations(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `unusedPrivateDeclarations .enable 簽名預設不展開 preserveDecls`() {
		#expect(FormatRule.unusedPrivateDeclarations(rule: .enable).cliArguments == [
			"--enable", "unusedPrivateDeclarations"
		])
	}

	@Test
	private func `unusedPrivateDeclarations .enable preserveDecls 自訂展開`() {
		let args = FormatRule.unusedPrivateDeclarations(
			rule: .enable,
			preserveDecls: "foo,bar"
		)
		.cliArguments
		#expect(args.contains("--preserveDecls"))
		#expect(args.contains("foo,bar"))
	}
}
