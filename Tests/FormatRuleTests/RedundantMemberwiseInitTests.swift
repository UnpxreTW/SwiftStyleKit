//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantMemberwiseInit")
private struct RedundantMemberwiseInitTests {

	@Test
	private func `redundantMemberwiseInit .disable 返空陣列`() {
		#expect(FormatRule.redundantMemberwiseInit(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `redundantMemberwiseInit .enable 簽名預設展開 --preferSynthesizedInitForInternalStructs never`() {
		let args = FormatRule.redundantMemberwiseInit(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "redundantMemberwiseInit",
			"--preferSynthesizedInitForInternalStructs", "never"
		])
	}

	@Test
	private func `redundantMemberwiseInit .enable mode .always 展開 always`() {
		let args = FormatRule.redundantMemberwiseInit(rule: .enable, mode: .always).cliArguments
		#expect(args == [
			"--enable", "redundantMemberwiseInit",
			"--preferSynthesizedInitForInternalStructs", "always"
		])
	}

	@Test
	private func `redundantMemberwiseInit .enable mode .conformances 展開逗號相連 protocol 名單`() {
		let args = FormatRule.redundantMemberwiseInit(
			rule: .enable,
			mode: .conformances(["View", "ViewModifier"])
		)
		.cliArguments
		#expect(args == [
			"--enable", "redundantMemberwiseInit",
			"--preferSynthesizedInitForInternalStructs", "View,ViewModifier"
		])
	}
}
