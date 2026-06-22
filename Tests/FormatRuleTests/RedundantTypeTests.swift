//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantType")
private struct RedundantTypeTests {

	@Test
	private func `redundantType .disable 返空陣列`() {
		let args = FormatRule.redundantType(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `redundantType .enable 只展開 --enable、不帶選項`() {
		let args = FormatRule.redundantType(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantType"])
	}
}
