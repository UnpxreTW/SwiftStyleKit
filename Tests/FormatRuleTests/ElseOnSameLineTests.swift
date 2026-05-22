//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("elseOnSameLine")
struct ElseOnSameLineTests {

	@Test
	func `elseOnSameLine .disable 返空陣列`() {
		let args = FormatRule.elseOnSameLine(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `elseOnSameLine .disable + options（被忽略）返空陣列`() {
		let args = FormatRule.elseOnSameLine(rule: .disable, elsePosition: .nextLine, guardElse: .auto).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `elseOnSameLine .enable（option 預設）展開 --enable + --elsePosition same-line + --guardElse next-line`() {
		let args = FormatRule.elseOnSameLine(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "elseOnSameLine",
			"--elsePosition", "same-line",
			"--guardElse", "next-line"
		])
	}

	@Test
	func `elseOnSameLine .enable elsePosition .nextLine 展開 --elsePosition next-line`() {
		let args = FormatRule.elseOnSameLine(rule: .enable, elsePosition: .nextLine).cliArguments
		#expect(args == [
			"--enable", "elseOnSameLine",
			"--elsePosition", "next-line",
			"--guardElse", "next-line"
		])
	}

	@Test
	func `elseOnSameLine .enable guardElse .sameLine 展開 --guardElse same-line`() {
		let args = FormatRule.elseOnSameLine(rule: .enable, guardElse: .sameLine).cliArguments
		#expect(args == [
			"--enable", "elseOnSameLine",
			"--elsePosition", "same-line",
			"--guardElse", "same-line"
		])
	}
}
