//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferFlatMap")
private struct PreferFlatMapTests {

	@Test
	private func `preferFlatMap .disable 返空陣列`() {
		let args = FormatRule.preferFlatMap(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `preferFlatMap .enable 展開 --enable preferFlatMap`() {
		let args = FormatRule.preferFlatMap(.on).cliArguments
		#expect(args == ["--enable", "preferFlatMap"])
	}
}
