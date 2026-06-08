//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("FormatRule")
private struct FormatRuleTests {

	@Test
	private func `allRules 不為空、enum 有 case 註冊`() {
		#expect(!FormatRule.allRules.isEmpty)
	}
}
