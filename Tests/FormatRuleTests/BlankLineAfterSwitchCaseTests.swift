//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLineAfterSwitchCase")
struct BlankLineAfterSwitchCaseTests {

	@Test
	func `blankLineAfterSwitchCase .disable（無 mode）返空陣列`() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `blankLineAfterSwitchCase .disable + mode（mode 被忽略）返空陣列`() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .disable, mode: .always).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `blankLineAfterSwitchCase .enable mode .multilineOnly 展開 --enable + flag multiline-only`() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .enable, mode: .multilineOnly).cliArguments
		#expect(args == [
			"--enable", "blankLineAfterSwitchCase",
			"--blankLineAfterSwitchCase", "multiline-only"
		])
	}

	@Test
	func `blankLineAfterSwitchCase .enable mode .always 展開 --enable + flag always`() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .enable, mode: .always).cliArguments
		#expect(args == [
			"--enable", "blankLineAfterSwitchCase",
			"--blankLineAfterSwitchCase", "always"
		])
	}

	@Test
	func `blankLineAfterSwitchCase .enable（mode nil 跳過、swiftformat 取上游預設）只展開 --enable`() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLineAfterSwitchCase"])
	}
}
