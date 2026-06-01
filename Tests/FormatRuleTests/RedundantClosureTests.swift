//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantClosure")
private struct RedundantClosureTests {

	@Test
	private func `redundantClosure .disable 返空陣列`() {
		#expect(FormatRule.redundantClosure(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantClosure .enable 展開 --enable redundantClosure`() {
		let args = FormatRule.redundantClosure(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantClosure"])
	}
}
