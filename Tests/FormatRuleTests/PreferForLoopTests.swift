//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferForLoop")
struct PreferForLoopTests {

	@Test("preferForLoop .disable 返空陣列")
	func preferForLoopDisable() {
		let args = FormatRule.preferForLoop(
			rule: .disable,
			anonymousForEach: .convert,
			singleLineForEach: .convert
		).cliArguments
		#expect(args.isEmpty)
	}

	@Test("preferForLoop .enable 預設值展開（兩個 option 都 ignore）")
	func preferForLoopEnableDefault() {
		let args = FormatRule.preferForLoop(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "preferForLoop",
			"--anonymousForEach", "ignore",
			"--singleLineForEach", "ignore"
		])
	}

	@Test("preferForLoop .enable 兩個 option 改 convert")
	func preferForLoopEnableConvert() {
		let args = FormatRule.preferForLoop(
			rule: .enable,
			anonymousForEach: .convert,
			singleLineForEach: .convert
		).cliArguments
		#expect(args == [
			"--enable", "preferForLoop",
			"--anonymousForEach", "convert",
			"--singleLineForEach", "convert"
		])
	}
}
