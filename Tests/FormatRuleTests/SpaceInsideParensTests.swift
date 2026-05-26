//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceInsideParens")
private struct SpaceInsideParensTests {

	@Test
	private func `spaceInsideParens .disable 返空陣列`() {
		#expect(FormatRule.spaceInsideParens(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `spaceInsideParens .enable 展開 --enable spaceInsideParens`() {
		let args = FormatRule.spaceInsideParens(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceInsideParens"])
	}
}
