//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("simplifyGenericConstraints")
private struct SimplifyGenericConstraintsTests {

	@Test
	private func `simplifyGenericConstraints .disable 返空陣列`() {
		#expect(FormatRule.simplifyGenericConstraints(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `simplifyGenericConstraints .enable 展開 --enable simplifyGenericConstraints`() {
		let args = FormatRule.simplifyGenericConstraints(rule: .enable).cliArguments
		#expect(args == ["--enable", "simplifyGenericConstraints"])
	}
}
