//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantSwiftUIGroup")
private struct RedundantSwiftUIGroupTests {

	@Test
	private func `redundantSwiftUIGroup .disable 返空陣列`() {
		let args = FormatRule.redundantSwiftUIGroup(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `redundantSwiftUIGroup .enable 展開 --enable redundantSwiftUIGroup`() {
		let args = FormatRule.redundantSwiftUIGroup(.on).cliArguments
		#expect(args == ["--enable", "redundantSwiftUIGroup"])
	}
}
