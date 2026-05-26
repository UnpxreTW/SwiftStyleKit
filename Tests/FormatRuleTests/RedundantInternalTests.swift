//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantInternal")
private struct RedundantInternalTests {

	@Test
	private func `redundantInternal .disable 返空陣列`() {
		#expect(FormatRule.redundantInternal(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantInternal .enable 展開 --enable redundantInternal`() {
		let args = FormatRule.redundantInternal(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantInternal"])
	}
}
