//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("anyObjectProtocol")
struct AnyObjectProtocolTests {

	@Test
	func `anyObjectProtocol .disable 返空陣列`() {
		let args = FormatRule.anyObjectProtocol(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `anyObjectProtocol .enable 展開 --enable anyObjectProtocol`() {
		let args = FormatRule.anyObjectProtocol(rule: .enable).cliArguments
		#expect(args == ["--enable", "anyObjectProtocol"])
	}
}
