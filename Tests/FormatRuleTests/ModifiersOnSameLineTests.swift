//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("modifiersOnSameLine")
private struct ModifiersOnSameLineTests {

	@Test
	private func `modifiersOnSameLine .disable 返空陣列`() {
		#expect(FormatRule.modifiersOnSameLine(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `modifiersOnSameLine .enable 展開 --enable modifiersOnSameLine`() {
		let args = FormatRule.modifiersOnSameLine(rule: .enable).cliArguments
		#expect(args == ["--enable", "modifiersOnSameLine"])
	}
}
