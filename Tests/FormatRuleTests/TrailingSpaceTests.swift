//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("trailingSpace")
struct TrailingSpaceTests {

	@Test
	func `trailingSpace .disable 返空陣列`() {
		#expect(FormatRule.trailingSpace(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `trailingSpace .enable 簽名預設展開 --trimWhitespace always`() {
		let args = FormatRule.trailingSpace(rule: .enable).cliArguments
		#expect(args == ["--enable", "trailingSpace", "--trimWhitespace", "always"])
	}

	@Test
	func `trailingSpace .enable mode .nonblankLines 展開 --trimWhitespace nonblank-lines`() {
		let args = FormatRule.trailingSpace(rule: .enable, mode: .nonblankLines).cliArguments
		#expect(args == ["--enable", "trailingSpace", "--trimWhitespace", "nonblank-lines"])
	}
}
