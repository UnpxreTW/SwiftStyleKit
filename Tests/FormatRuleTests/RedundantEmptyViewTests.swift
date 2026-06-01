//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantEmptyView")
private struct RedundantEmptyViewTests {

	@Test
	private func `redundantEmptyView .disable 返空陣列`() {
		#expect(FormatRule.redundantEmptyView(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantEmptyView .enable 展開 --enable redundantEmptyView`() {
		let args = FormatRule.redundantEmptyView(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantEmptyView"])
	}
}
