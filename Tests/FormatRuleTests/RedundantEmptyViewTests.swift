//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantEmptyView")
struct RedundantEmptyViewTests {

	@Test("redundantEmptyView .disable 返空陣列")
	func redundantEmptyViewDisable() {
		#expect(FormatRule.redundantEmptyView(rule: .disable).cliArguments.isEmpty)
	}

	@Test("redundantEmptyView .enable 展開 --enable redundantEmptyView")
	func redundantEmptyViewEnable() {
		let args = FormatRule.redundantEmptyView(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantEmptyView"])
	}
}
