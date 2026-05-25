//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantViewBuilder")
struct RedundantViewBuilderTests {

	@Test
	func `redundantViewBuilder .disable 返空陣列`() {
		#expect(FormatRule.redundantViewBuilder(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantViewBuilder .enable 展開 --enable redundantViewBuilder`() {
		let args = FormatRule.redundantViewBuilder(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantViewBuilder"])
	}
}
