//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantExtensionACL")
private struct RedundantExtensionACLTests {

	@Test
	private func `redundantExtensionACL .disable 返空陣列`() {
		#expect(FormatRule.redundantExtensionACL(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantExtensionACL .enable 展開 --enable redundantExtensionACL`() {
		let args = FormatRule.redundantExtensionACL(rule: .enable).cliArguments
		#expect(args == ["--enable", "redundantExtensionACL"])
	}
}
