//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("hoistAwait")
struct HoistAwaitTests {

	@Test
	func `hoistAwait .disable 返空陣列`() {
		let args = FormatRule.hoistAwait(rule: .disable, asyncCapturing: "foo").cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `hoistAwait .enable（asyncCapturing 預設 nil）只展開 --enable`() {
		let args = FormatRule.hoistAwait(rule: .enable).cliArguments
		#expect(args == ["--enable", "hoistAwait"])
	}

	@Test
	func `hoistAwait .enable asyncCapturing 有值展開 --asyncCapturing`() {
		let args = FormatRule.hoistAwait(rule: .enable, asyncCapturing: "withChecked").cliArguments
		#expect(args == [
			"--enable", "hoistAwait",
			"--asyncCapturing", "withChecked",
		])
	}
}
