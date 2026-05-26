//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferSwiftStringAPI")
struct PreferSwiftStringAPITests {

	@Test
	func `preferSwiftStringAPI .disable 返空陣列`() {
		#expect(FormatRule.preferSwiftStringAPI(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `preferSwiftStringAPI .enable 展開 --enable preferSwiftStringAPI`() {
		let args = FormatRule.preferSwiftStringAPI(rule: .enable).cliArguments
		#expect(args == ["--enable", "preferSwiftStringAPI"])
	}
}
