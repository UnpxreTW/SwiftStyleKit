//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("initCoderUnavailable")
struct InitCoderUnavailableTests {

	@Test("initCoderUnavailable .disable 返空陣列")
	func initCoderUnavailableDisable() {
		let args = FormatRule.initCoderUnavailable(rule: .disable, initCoderNil: .enable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("initCoderUnavailable .enable（initCoderNil 預設 .disable）展開 --enable + --initCoderNil false")
	func initCoderUnavailableEnableDefault() {
		let args = FormatRule.initCoderUnavailable(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "initCoderUnavailable",
			"--initCoderNil", "false"
		])
	}

	@Test("initCoderUnavailable .enable initCoderNil .enable 展開 --initCoderNil true")
	func initCoderUnavailableEnableNil() {
		let args = FormatRule.initCoderUnavailable(rule: .enable, initCoderNil: .enable).cliArguments
		#expect(args == [
			"--enable", "initCoderUnavailable",
			"--initCoderNil", "true"
		])
	}
}
