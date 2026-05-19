//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("markTypes")
struct MarkTypesTests {

	@Test("markTypes .disable 返空陣列")
	func markTypesDisable() {
		#expect(FormatRule.markTypes(rule: .disable).cliArguments.isEmpty)
	}

	@Test("markTypes .enable 預設值展開（types never / extensions always / 自訂 extensionMark）")
	func markTypesEnableDefault() {
		let args = FormatRule.markTypes(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "markTypes",
			"--markTypes", "never",
			"--markExtensions", "always",
			"--extensionMark", "MARK: - + %c"
		])
	}

	@Test("markTypes .enable 帶 typeMark / groupedExtension 展開全部 option")
	func markTypesEnableAllOptions() {
		let args = FormatRule.markTypes(
			rule: .enable,
			markTypes: .always,
			typeMark: "MARK: - %t",
			markExtensions: .ifNotEmpty,
			extensionMark: "MARK: %c",
			groupedExtension: "MARK: %c"
		).cliArguments
		#expect(args == [
			"--enable", "markTypes",
			"--markTypes", "always",
			"--typeMark", "MARK: - %t",
			"--markExtensions", "if-not-empty",
			"--extensionMark", "MARK: %c",
			"--groupedExtension", "MARK: %c"
		])
	}
}
