//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceAroundBrackets")
private struct SpaceAroundBracketsTests {

	@Test
	private func `spaceAroundBrackets .disable 返空陣列`() {
		#expect(FormatRule.spaceAroundBrackets(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `spaceAroundBrackets .enable 展開 --enable spaceAroundBrackets`() {
		let args = FormatRule.spaceAroundBrackets(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceAroundBrackets"])
	}
}
