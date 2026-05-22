//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("modifiersOnSameLine")
struct ModifiersOnSameLineTests {

	@Test
	func `modifiersOnSameLine .disable 返空陣列`() {
		#expect(FormatRule.modifiersOnSameLine(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `modifiersOnSameLine .enable 展開 --enable modifiersOnSameLine`() {
		let args = FormatRule.modifiersOnSameLine(rule: .enable).cliArguments
		#expect(args == ["--enable", "modifiersOnSameLine"])
	}
}
