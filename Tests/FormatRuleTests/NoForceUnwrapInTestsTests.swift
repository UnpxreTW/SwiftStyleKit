//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("noForceUnwrapInTests")
private struct NoForceUnwrapInTestsTests {

	@Test
	private func `noForceUnwrapInTests .disable 返空陣列`() {
		#expect(FormatRule.noForceUnwrapInTests(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `noForceUnwrapInTests .enable 展開 --enable noForceUnwrapInTests`() {
		let args = FormatRule.noForceUnwrapInTests(rule: .enable).cliArguments
		#expect(args == ["--enable", "noForceUnwrapInTests"])
	}
}
