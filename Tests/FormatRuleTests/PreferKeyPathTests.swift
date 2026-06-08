//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

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
