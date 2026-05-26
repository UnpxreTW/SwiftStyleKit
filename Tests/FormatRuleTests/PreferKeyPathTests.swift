//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferKeyPath")
private struct PreferKeyPathTests {

	@Test
	private func `preferKeyPath .disable 返空陣列`() {
		#expect(FormatRule.preferKeyPath(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `preferKeyPath .enable 展開 --enable preferKeyPath`() {
		let args = FormatRule.preferKeyPath(rule: .enable).cliArguments
		#expect(args == ["--enable", "preferKeyPath"])
	}
}
