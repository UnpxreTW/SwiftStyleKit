//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("indent")
struct IndentTests {

	@Test
	func `indent .disable 返空陣列`() {
		#expect(FormatRule.indent(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `indent .enable 預設值展開（tab / outdent / indentStrings）`() {
		let args = FormatRule.indent(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "indent",
			"--indent", "tab",
			"--smartTabs", "true",
			"--indentCase", "false",
			"--ifdef", "outdent",
			"--xcodeIndentation", "false",
			"--indentStrings", "true",
		])
	}

	@Test
	func `indent .spaces 與 tabWidth 展開`() {
		let args = FormatRule.indent(rule: .enable, indent: .spaces(2), tabWidth: 4).cliArguments
		#expect(args == [
			"--enable", "indent",
			"--indent", "2",
			"--tabWidth", "4",
			"--smartTabs", "true",
			"--indentCase", "false",
			"--ifdef", "outdent",
			"--xcodeIndentation", "false",
			"--indentStrings", "true",
		])
	}
}
