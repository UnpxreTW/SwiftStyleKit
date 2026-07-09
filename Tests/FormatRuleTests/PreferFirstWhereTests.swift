//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferFirstWhere")
private struct PreferFirstWhereTests {

	@Test
	private func `preferFirstWhere .disable 返空陣列`() {
		let args = FormatRule.preferFirstWhere(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `preferFirstWhere .enable 展開 --enable preferFirstWhere`() {
		let args = FormatRule.preferFirstWhere(.on).cliArguments
		#expect(args == ["--enable", "preferFirstWhere"])
	}
}
