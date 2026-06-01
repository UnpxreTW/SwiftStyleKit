//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantGet")
private struct RedundantGetTests {

	@Test
	private func `redundantGet .disable 返空陣列`() {
		#expect(FormatRule.redundantGet(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantGet .enable 展開 --enable redundantGet`() {
		let args = FormatRule.redundantGet(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantGet"])
	}
}
