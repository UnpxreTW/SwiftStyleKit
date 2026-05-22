//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("hoistTry")
struct HoistTryTests {

	@Test
	func `hoistTry .disable 返空陣列`() {
		let args = FormatRule.hoistTry(rule: .disable, throwCapturing: "foo").cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `hoistTry .enable（throwCapturing 預設 nil）只展開 --enable`() {
		let args = FormatRule.hoistTry(rule: .enable).cliArguments
		#expect(args == ["--enable", "hoistTry"])
	}

	@Test
	func `hoistTry .enable throwCapturing 有值展開 --throwCapturing`() {
		let args = FormatRule.hoistTry(rule: .enable, throwCapturing: "expect").cliArguments
		#expect(args == [
			"--enable", "hoistTry",
			"--throwCapturing", "expect"
		])
	}
}
