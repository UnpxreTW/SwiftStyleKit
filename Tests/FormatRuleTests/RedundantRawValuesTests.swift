//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantRawValues")
private struct RedundantRawValuesTests {

	@Test
	private func `redundantRawValues .disable 返空陣列`() {
		#expect(FormatRule.redundantRawValues(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantRawValues .enable 展開 --enable redundantRawValues`() {
		let args = FormatRule.redundantRawValues(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantRawValues"])
	}
}
