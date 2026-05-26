//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("spaceInsideComments")
private struct SpaceInsideCommentsTests {

	@Test
	private func `spaceInsideComments .disable 返空陣列`() {
		#expect(FormatRule.spaceInsideComments(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `spaceInsideComments .enable 展開 --enable spaceInsideComments`() {
		let args = FormatRule.spaceInsideComments(rule: .enable).cliArguments
		#expect(args == ["--enable", "spaceInsideComments"])
	}
}
