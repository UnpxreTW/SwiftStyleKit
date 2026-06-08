//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferForLoop")
private struct PreferForLoopTests {

	@Test
	private func `preferForLoop .disable 返空陣列`() {
		let args = FormatRule.preferForLoop(
			rule: .disable,
			anonymousForEach: .convert,
			singleLineForEach: .convert
		)
		.cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `preferForLoop .enable 預設值展開（兩個 option 都 ignore）`() {
		let args = FormatRule.preferForLoop(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "preferForLoop",
			"--anonymousForEach", "ignore",
			"--singleLineForEach", "ignore"
		])
	}

	@Test
	private func `preferForLoop .enable 兩個 option 改 convert`() {
		let args = FormatRule.preferForLoop(
			rule: .enable,
			anonymousForEach: .convert,
			singleLineForEach: .convert
		)
		.cliArguments
		#expect(args == [
			"--enable", "preferForLoop",
			"--anonymousForEach", "convert",
			"--singleLineForEach", "convert"
		])
	}
}
