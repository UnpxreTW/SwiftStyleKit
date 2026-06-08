//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceInsideGenerics")
private struct SpaceInsideGenericsTests {

	@Test
	private func `spaceInsideGenerics .disable 返空陣列`() {
		#expect(FormatRule.spaceInsideGenerics(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `spaceInsideGenerics .enable 展開 --enable spaceInsideGenerics`() {
		let args = FormatRule.spaceInsideGenerics(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceInsideGenerics"])
	}
}
