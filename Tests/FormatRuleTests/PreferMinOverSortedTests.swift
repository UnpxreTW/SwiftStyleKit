//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferMinOverSorted")
private struct PreferMinOverSortedTests {

	@Test
	private func `preferMinOverSorted .disable 返空陣列`() {
		let args = FormatRule.preferMinOverSorted(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `preferMinOverSorted .enable 展開 --enable preferMinOverSorted`() {
		let args = FormatRule.preferMinOverSorted(.on).cliArguments
		#expect(args == ["--enable", "preferMinOverSorted"])
	}
}
