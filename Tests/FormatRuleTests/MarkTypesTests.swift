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
private struct MarkTypesTests {

	@Test
	private func `markTypes .disable 返空陣列`() {
		#expect(FormatRule.markTypes(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `markTypes .enable 預設值展開（types/extensions always、自訂 extensionMark/groupedExtension）`() {
		let args = FormatRule.markTypes(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "markTypes",
			"--markTypes", "always",
			"--markExtensions", "always",
			"--extensionMark", "MARK: - + %c",
			"--groupedExtension", "MARK: - + %c"
		])
	}

	@Test
	private func `markTypes .enable 帶 typeMark / groupedExtension 展開全部 option`() {
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
