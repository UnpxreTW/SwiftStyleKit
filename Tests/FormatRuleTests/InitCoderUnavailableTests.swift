//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("initCoderUnavailable")
private struct InitCoderUnavailableTests {

	@Test
	private func `initCoderUnavailable .disable 返空陣列`() {
		let args = FormatRule.initCoderUnavailable(rule: .disable, initCoderNil: .enable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `initCoderUnavailable .enable（initCoderNil 預設 .disable）展開 --enable + --initCoderNil false`() {
		let args = FormatRule.initCoderUnavailable(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "initCoderUnavailable",
			"--initCoderNil", "false"
		])
	}

	@Test
	private func `initCoderUnavailable .enable initCoderNil .enable 展開 --initCoderNil true`() {
		let args = FormatRule.initCoderUnavailable(rule: .enable, initCoderNil: .enable).cliArguments
		#expect(args == [
			"--enable", "initCoderUnavailable",
			"--initCoderNil", "true"
		])
	}
}
