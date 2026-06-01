//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("noForceTryInTests")
private struct NoForceTryInTestsTests {

	@Test
	private func `noForceTryInTests .disable 返空陣列`() {
		#expect(FormatRule.noForceTryInTests(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `noForceTryInTests .enable 展開 --enable noForceTryInTests`() {
		let args = FormatRule.noForceTryInTests(rule: .enable).cliArguments
		#expect(args == ["--enable", "noForceTryInTests"])
	}
}
