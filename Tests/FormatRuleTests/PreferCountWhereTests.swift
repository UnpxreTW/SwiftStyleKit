//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferCountWhere")
private struct PreferCountWhereTests {

	@Test
	private func `preferCountWhere .disable 返空陣列`() {
		#expect(FormatRule.preferCountWhere(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `preferCountWhere .enable 展開 --enable preferCountWhere`() {
		let args = FormatRule.preferCountWhere(rule: .enable).cliArguments
		#expect(args == ["--enable", "preferCountWhere"])
	}
}
