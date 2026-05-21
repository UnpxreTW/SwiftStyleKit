//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("strongOutlets")
struct StrongOutletsTests {

	@Test("strongOutlets .disable 返空陣列")
	func strongOutletsDisable() {
		#expect(FormatRule.strongOutlets(rule: .disable).cliArguments.isEmpty)
	}

	@Test("strongOutlets .enable 展開 --enable strongOutlets")
	func strongOutletsEnable() {
		let args = FormatRule.strongOutlets(rule: .enable).cliArguments
		#expect(args == ["--enable", "strongOutlets"])
	}
}
