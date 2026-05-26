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
private struct NoExplicitOwnershipTests {

	@Test
	private func `noExplicitOwnership .disable 返空陣列`() {
		#expect(FormatRule.noExplicitOwnership(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `noExplicitOwnership .enable 展開 --enable noExplicitOwnership`() {
		let args = FormatRule.noExplicitOwnership(rule: .enable).cliArguments
		#expect(args == ["--enable", "noExplicitOwnership"])
	}
}
