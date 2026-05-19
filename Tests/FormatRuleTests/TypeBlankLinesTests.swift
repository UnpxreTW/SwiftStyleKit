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

	@Test("typeBlankLines mode nil 不展開、返空陣列（由 swiftformat 取上游預設）")
	func typeBlankLinesNil() {
		let args = FormatRule.typeBlankLines(mode: nil).cliArguments
		#expect(args.isEmpty)
	}

	@Test("typeBlankLines mode .remove 展開 --typeBlankLines remove")
	func typeBlankLinesRemove() {
		let args = FormatRule.typeBlankLines(mode: .remove).cliArguments
		#expect(args == ["--typeBlankLines", "remove"])
	}

	@Test("typeBlankLines mode .insert 展開 --typeBlankLines insert")
	func typeBlankLinesInsert() {
		let args = FormatRule.typeBlankLines(mode: .insert).cliArguments
		#expect(args == ["--typeBlankLines", "insert"])
	}

	@Test("typeBlankLines mode .preserve 展開 --typeBlankLines preserve")
	func typeBlankLinesPreserve() {
		let args = FormatRule.typeBlankLines(mode: .preserve).cliArguments
		#expect(args == ["--typeBlankLines", "preserve"])
	}

	@Test("typeBlankLines 預設（mode 省略 → .preserve）展開 --typeBlankLines preserve")
	func typeBlankLinesDefault() {
		let args = FormatRule.typeBlankLines().cliArguments
		#expect(args == ["--typeBlankLines", "preserve"])
	}
}
