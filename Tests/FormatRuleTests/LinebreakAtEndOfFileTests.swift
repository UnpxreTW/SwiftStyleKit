//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("linebreakAtEndOfFile")
struct LinebreakAtEndOfFileTests {

	@Test("linebreakAtEndOfFile .disable 返空陣列")
	func linebreakAtEndOfFileDisable() {
		#expect(FormatRule.linebreakAtEndOfFile(rule: .disable).cliArguments.isEmpty)
	}

	@Test("linebreakAtEndOfFile .enable 展開 --enable linebreakAtEndOfFile")
	func linebreakAtEndOfFileEnable() {
		let args = FormatRule.linebreakAtEndOfFile(rule: .enable).cliArguments
		#expect(args == ["--enable", "linebreakAtEndOfFile"])
	}
}
