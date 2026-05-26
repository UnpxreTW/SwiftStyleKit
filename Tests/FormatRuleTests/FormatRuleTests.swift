//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("FormatRule")
private struct FormatRuleTests {

	@Test
	private func `allRules 不為空、enum 有 case 註冊`() {
		#expect(!FormatRule.allRules.isEmpty)
	}
}
