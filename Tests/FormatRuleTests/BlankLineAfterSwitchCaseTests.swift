//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLineAfterSwitchCase")
private struct BlankLineAfterSwitchCaseTests {

	@Test
	private func `blankLineAfterSwitchCase .disable（無 mode）返空陣列`() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `blankLineAfterSwitchCase .disable + mode（mode 被忽略）返空陣列`() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .disable, mode: .always).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `blankLineAfterSwitchCase .enable mode .multilineOnly 展開 --enable + flag multiline-only`() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .enable, mode: .multilineOnly).cliArguments
		#expect(args == [
			"--enable", "blankLineAfterSwitchCase",
			"--blankLineAfterSwitchCase", "multiline-only"
		])
	}

	@Test
	private func `blankLineAfterSwitchCase .enable mode .always 展開 --enable + flag always`() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .enable, mode: .always).cliArguments
		#expect(args == [
			"--enable", "blankLineAfterSwitchCase",
			"--blankLineAfterSwitchCase", "always"
		])
	}

	@Test
	private func `blankLineAfterSwitchCase .enable（mode nil 跳過、swiftformat 取上游預設）只展開 --enable`() {
		let args = FormatRule.blankLineAfterSwitchCase(rule: .enable).cliArguments
		#expect(args == ["--enable", "blankLineAfterSwitchCase"])
	}
}
