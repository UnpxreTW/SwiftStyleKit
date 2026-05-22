//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("typeBlankLines")
struct TypeBlankLinesTests {

	@Test
	func `typeBlankLines mode nil 不展開、返空陣列（由 swiftformat 取上游預設）`() {
		let args = FormatRule.typeBlankLines(mode: nil).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `typeBlankLines mode .remove 展開 --typeBlankLines remove`() {
		let args = FormatRule.typeBlankLines(mode: .remove).cliArguments
		#expect(args == ["--typeBlankLines", "remove"])
	}

	@Test
	func `typeBlankLines mode .insert 展開 --typeBlankLines insert`() {
		let args = FormatRule.typeBlankLines(mode: .insert).cliArguments
		#expect(args == ["--typeBlankLines", "insert"])
	}

	@Test
	func `typeBlankLines mode .preserve 展開 --typeBlankLines preserve`() {
		let args = FormatRule.typeBlankLines(mode: .preserve).cliArguments
		#expect(args == ["--typeBlankLines", "preserve"])
	}

	@Test
	func `typeBlankLines 預設（mode 省略 → .preserve）展開 --typeBlankLines preserve`() {
		let args = FormatRule.typeBlankLines().cliArguments
		#expect(args == ["--typeBlankLines", "preserve"])
	}
}
