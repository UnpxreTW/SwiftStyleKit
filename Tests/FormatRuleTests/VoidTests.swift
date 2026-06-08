//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("void")
private struct VoidTests {

	@Test
	private func `void .disable 返空陣列`() {
		#expect(FormatRule.void(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `void .enable 簽名預設展開 --voidType Void`() {
		let args = FormatRule.void(rule: .enable).cliArguments
		#expect(args == ["--enable", "void", "--voidType", "Void"])
	}

	@Test
	private func `void .enable mode .tuple 展開 --voidType tuple`() {
		let args = FormatRule.void(rule: .enable, mode: .tuple).cliArguments
		#expect(args == ["--enable", "void", "--voidType", "tuple"])
	}
}
