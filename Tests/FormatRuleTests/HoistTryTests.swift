//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("hoistTry")
private struct HoistTryTests {

	@Test
	private func `hoistTry .disable 返空陣列`() {
		let args = FormatRule.hoistTry(rule: .disable, throwCapturing: "foo").cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `hoistTry .enable（throwCapturing 預設 nil）只展開 --enable`() {
		let args = FormatRule.hoistTry(rule: .enable).cliArguments
		#expect(args == ["--enable", "hoistTry"])
	}

	@Test
	private func `hoistTry .enable throwCapturing 有值展開 --throwCapturing`() {
		let args = FormatRule.hoistTry(rule: .enable, throwCapturing: "expect").cliArguments
		#expect(args == [
			"--enable", "hoistTry",
			"--throwCapturing", "expect"
		])
	}
}
