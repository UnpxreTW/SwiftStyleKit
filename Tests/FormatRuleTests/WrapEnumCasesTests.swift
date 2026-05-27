//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapEnumCases")
private struct WrapEnumCasesTests {

	@Test
	private func `wrapEnumCases .disable 返空陣列`() {
		#expect(FormatRule.wrapEnumCases(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapEnumCases .enable 簽名預設展開 always`() {
		#expect(FormatRule.wrapEnumCases(rule: .enable).cliArguments == [
			"--enable", "wrapEnumCases",
			"--wrapEnumCases", "always"
		])
	}

	@Test
	private func `wrapEnumCases .enable withValues 展開`() {
		let args = FormatRule.wrapEnumCases(rule: .enable, wrapEnumCases: .withValues).cliArguments
		#expect(args.contains("--wrapEnumCases"))
		#expect(args.contains("with-values"))
	}
}
