//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
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
	private func `typeBlankLines mode .consistent 展開 --typeBlankLines consistent`() {
		let args = FormatRule.typeBlankLines(mode: .consistent).cliArguments
		#expect(args == ["--typeBlankLines", "consistent"])
	}

	@Test
	private func `typeBlankLines mode .startOnly 展開 kebab-case 的 start-only`() {
		let args = FormatRule.typeBlankLines(mode: .startOnly).cliArguments
		#expect(args == ["--typeBlankLines", "start-only"])
	}

	@Test
	private func `typeBlankLines mode .endOnly 展開 kebab-case 的 end-only`() {
		let args = FormatRule.typeBlankLines(mode: .endOnly).cliArguments
		#expect(args == ["--typeBlankLines", "end-only"])
	}

	@Test
	private func `typeBlankLines 預設（mode 省略 → .preserve）展開 --typeBlankLines preserve`() {
		let args = FormatRule.typeBlankLines().cliArguments
		#expect(args == ["--typeBlankLines", "preserve"])
	}

	/// allRules 是 SwiftStyleKit 的規則政策所在，type 宣告邊界的實際選用值釘在這裡。
	@Test
	private func `allRules 選用 start-only：type 宣告開頭留空白行、結尾不留`() throws {
		let command: [String] = FormatRule.allToCommand
		let flagIndex: Int = try #require(command.firstIndex(of: "--typeBlankLines"))
		#expect(command[command.index(after: flagIndex)] == "start-only")
	}
}
