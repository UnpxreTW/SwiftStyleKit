//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferContains")
private struct PreferContainsTests {

	@Test
	private func `preferContains .disable 返空陣列`() {
		let args = FormatRule.preferContains(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `preferContains .enable 展開 --enable preferContains`() {
		let args = FormatRule.preferContains(.on).cliArguments
		#expect(args == ["--enable", "preferContains"])
	}
}
