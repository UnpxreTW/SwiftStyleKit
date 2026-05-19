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

	@Test("blankLineAfterSwitchCase .disable（無 mode）返空陣列")
	func blankLineAfterSwitchCaseDisableNoMode() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("blankLineAfterSwitchCase .disable + mode（mode 被忽略）返空陣列")
	func blankLineAfterSwitchCaseDisableWithMode() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .disable, mode: .always).cliArguments
		#expect(args.isEmpty)
	}

	@Test("blankLineAfterSwitchCase .enable mode .multilineOnly 展開 --enable + flag multiline-only")
	func blankLineAfterSwitchCaseEnableMultilineOnly() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .enable, mode: .multilineOnly).cliArguments
		#expect(args == [
			"--enable", "blankLineAfterSwitchCase",
			"--blankLineAfterSwitchCase", "multiline-only"
		])
	}

	@Test("blankLineAfterSwitchCase .enable mode .always 展開 --enable + flag always")
	func blankLineAfterSwitchCaseEnableAlways() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .enable, mode: .always).cliArguments
		#expect(args == [
			"--enable", "blankLineAfterSwitchCase",
			"--blankLineAfterSwitchCase", "always"
		])
	}

	@Test("blankLineAfterSwitchCase .enable（mode nil 跳過、swiftformat 取上游預設）只展開 --enable")
	func blankLineAfterSwitchCaseEnableNoMode() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLineAfterSwitchCase"])
	}
}
