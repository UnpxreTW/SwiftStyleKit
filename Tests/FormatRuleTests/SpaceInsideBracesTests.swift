//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceInsideBraces")
private struct SpaceInsideBracesTests {

	@Test
	private func `spaceInsideBraces .disable 返空陣列`() {
		#expect(FormatRule.spaceInsideBraces(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `spaceInsideBraces .enable 展開 --enable spaceInsideBraces`() {
		let args = FormatRule.spaceInsideBraces(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceInsideBraces"])
	}
}
