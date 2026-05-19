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

	@Test("modifiersOnSameLine .disable 返空陣列")
	func modifiersOnSameLineDisable() {
		#expect(FormatRule.modifiersOnSameLine(rule: .disable).cliArguments.isEmpty)
	}

	@Test("modifiersOnSameLine .enable 展開 --enable modifiersOnSameLine")
	func modifiersOnSameLineEnable() {
		let args = FormatRule.modifiersOnSameLine(rule: .enable).cliArguments
		#expect(args == ["--enable", "modifiersOnSameLine"])
	}
}
