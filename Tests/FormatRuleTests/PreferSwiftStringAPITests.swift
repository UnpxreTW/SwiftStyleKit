//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferSwiftStringAPI")
private struct PreferSwiftStringAPITests {

	@Test
	private func `preferSwiftStringAPI .disable 返空陣列`() {
		#expect(FormatRule.preferSwiftStringAPI(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `preferSwiftStringAPI .enable 展開 --enable preferSwiftStringAPI`() {
		let args = FormatRule.preferSwiftStringAPI(rule: .enable).cliArguments
		#expect(args == ["--enable", "preferSwiftStringAPI"])
	}
}
