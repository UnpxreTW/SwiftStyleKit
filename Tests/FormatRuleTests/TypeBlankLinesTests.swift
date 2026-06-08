//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("typeBlankLines")
private struct TypeBlankLinesTests {

	@Test
	private func `typeBlankLines mode nil 不展開、返空陣列（由 swiftformat 取上游預設）`() {
		let args = FormatRule.typeBlankLines(mode: nil).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `typeBlankLines mode .remove 展開 --typeBlankLines remove`() {
		let args = FormatRule.typeBlankLines(mode: .remove).cliArguments
		#expect(args == ["--typeBlankLines", "remove"])
	}

	@Test
	private func `typeBlankLines mode .insert 展開 --typeBlankLines insert`() {
		let args = FormatRule.typeBlankLines(mode: .insert).cliArguments
		#expect(args == ["--typeBlankLines", "insert"])
	}

	@Test
	private func `typeBlankLines mode .preserve 展開 --typeBlankLines preserve`() {
		let args = FormatRule.typeBlankLines(mode: .preserve).cliArguments
		#expect(args == ["--typeBlankLines", "preserve"])
	}

	@Test
	private func `typeBlankLines 預設（mode 省略 → .preserve）展開 --typeBlankLines preserve`() {
		let args = FormatRule.typeBlankLines().cliArguments
		#expect(args == ["--typeBlankLines", "preserve"])
	}
}
