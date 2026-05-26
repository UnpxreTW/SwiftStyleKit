//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantFileprivate")
private struct RedundantFileprivateTests {

	@Test
	private func `redundantFileprivate .disable 返空陣列`() {
		#expect(FormatRule.redundantFileprivate(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantFileprivate .enable 展開 --enable redundantFileprivate`() {
		let args = FormatRule.redundantFileprivate(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantFileprivate"])
	}
}
