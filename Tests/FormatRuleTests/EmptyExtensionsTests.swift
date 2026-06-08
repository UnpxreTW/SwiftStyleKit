//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("emptyExtensions")
private struct EmptyExtensionsTests {

	@Test
	private func `emptyExtensions .disable 返空陣列`() {
		let args = FormatRule.emptyExtensions(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `emptyExtensions .enable 展開 --enable emptyExtensions`() {
		let args = FormatRule.emptyExtensions(rule: .enable).cliArguments
		#expect(args == ["--enable", "emptyExtensions"])
	}
}
