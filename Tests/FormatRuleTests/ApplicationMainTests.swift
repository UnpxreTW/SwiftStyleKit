//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("applicationMain")
struct ApplicationMainTests {

	@Test
	func `applicationMain .disable 返空陣列`() {
		let args = FormatRule.applicationMain(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `applicationMain .enable 展開 --enable applicationMain`() {
		let args = FormatRule.applicationMain(rule: .enable).cliArguments
		#expect(args == ["--enable", "applicationMain"])
	}
}
