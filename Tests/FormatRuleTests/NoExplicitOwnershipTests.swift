//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("noExplicitOwnership")
struct NoExplicitOwnershipTests {

	@Test
	func `noExplicitOwnership .disable 返空陣列`() {
		#expect(FormatRule.noExplicitOwnership(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `noExplicitOwnership .enable 展開 --enable noExplicitOwnership`() {
		let args = FormatRule.noExplicitOwnership(rule: .enable).cliArguments
		#expect(args == ["--enable", "noExplicitOwnership"])
	}
}
