//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantVariable")
private struct RedundantVariableTests {

	@Test
	private func `redundantVariable .disable 返空陣列`() {
		#expect(FormatRule.redundantVariable(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantVariable .enable 展開 --enable redundantVariable`() {
		let args = FormatRule.redundantVariable(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantVariable"])
	}
}
