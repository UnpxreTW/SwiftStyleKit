//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("singlePropertyPerLine")
private struct SinglePropertyPerLineTests {

	@Test
	private func `singlePropertyPerLine .disable 返空陣列`() {
		#expect(FormatRule.singlePropertyPerLine(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `singlePropertyPerLine .enable 只 enable 不展開 option`() {
		#expect(FormatRule.singlePropertyPerLine(rule: .enable).cliArguments == ["--enable", "singlePropertyPerLine"])
	}
}
