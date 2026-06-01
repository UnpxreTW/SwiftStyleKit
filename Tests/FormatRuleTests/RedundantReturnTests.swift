//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantReturn")
private struct RedundantReturnTests {

	@Test
	private func `redundantReturn .disable 返空陣列`() {
		#expect(FormatRule.redundantReturn(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantReturn .enable 展開 --enable redundantReturn`() {
		let args = FormatRule.redundantReturn(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantReturn"])
	}
}
