//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantExtensionACL")
struct RedundantExtensionACLTests {

	@Test
	func `redundantExtensionACL .disable 返空陣列`() {
		#expect(FormatRule.redundantExtensionACL(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `redundantExtensionACL .enable 展開 --enable redundantExtensionACL`() {
		let args = FormatRule.redundantExtensionACL(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantExtensionACL"])
	}
}
