//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantBreak")
private struct RedundantBreakTests {

	@Test
	private func `redundantBreak .disable 返空陣列`() {
		#expect(FormatRule.redundantBreak(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantBreak .enable 展開 --enable redundantBreak`() {
		let args = FormatRule.redundantBreak(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantBreak"])
	}
}
