//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantThrows")
private struct RedundantThrowsTests {

	@Test
	private func `redundantThrows .disable 返空陣列`() {
		#expect(FormatRule.redundantThrows(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantThrows .enable 簽名預設展開 --redundantThrows tests-only`() {
		let args = FormatRule.redundantThrows(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "redundantThrows",
			"--redundantThrows", "tests-only"
		])
	}

	@Test
	private func `redundantThrows .enable redundantThrows .always 展開 --redundantThrows always`() {
		let args = FormatRule.redundantThrows(rule: .enable, redundantThrows: .always).cliArguments
		#expect(args == [
			"--enable", "redundantThrows",
			"--redundantThrows", "always"
		])
	}
}
