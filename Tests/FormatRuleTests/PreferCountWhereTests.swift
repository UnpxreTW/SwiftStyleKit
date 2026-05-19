//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferCountWhere")
struct PreferCountWhereTests {

	@Test("preferCountWhere .disable 返空陣列")
	func preferCountWhereDisable() {
		#expect(FormatRule.preferCountWhere(rule: .disable).cliArguments.isEmpty)
	}

	@Test("preferCountWhere .enable 展開 --enable preferCountWhere")
	func preferCountWhereEnable() {
		let args = FormatRule.preferCountWhere(rule: .enable).cliArguments
		#expect(args == ["--enable", "preferCountWhere"])
	}
}
