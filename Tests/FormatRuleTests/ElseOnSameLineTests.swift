//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("elseOnSameLine")
private struct ElseOnSameLineTests {

	@Test
	private func `elseOnSameLine .disable 返空陣列`() {
		let args = FormatRule.elseOnSameLine(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `elseOnSameLine .enable（option 預設）展開 --enable + --elsePosition same-line + --guardElse next-line`() {
		let args = FormatRule.elseOnSameLine(.on).cliArguments
		#expect(args == [
			"--enable", "elseOnSameLine",
			"--elsePosition", "same-line",
			"--guardElse", "next-line"
		])
	}

	@Test
	private func `elseOnSameLine .enable elsePosition .nextLine 展開 --elsePosition next-line`() {
		let args = FormatRule.elseOnSameLine(.on, elsePosition: .nextLine).cliArguments
		#expect(args == [
			"--enable", "elseOnSameLine",
			"--elsePosition", "next-line",
			"--guardElse", "next-line"
		])
	}

	@Test
	private func `elseOnSameLine .enable guardElse .sameLine 展開 --guardElse same-line`() {
		let args = FormatRule.elseOnSameLine(.on, guardElse: .sameLine).cliArguments
		#expect(args == [
			"--enable", "elseOnSameLine",
			"--elsePosition", "same-line",
			"--guardElse", "same-line"
		])
	}
}
