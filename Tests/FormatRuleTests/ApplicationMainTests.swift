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

	@Test("applicationMain .disable 返空陣列")
	func applicationMainDisable() {
		let args = FormatRule.applicationMain(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("applicationMain .enable 展開 --enable applicationMain")
	func applicationMainEnable() {
		let args = FormatRule.applicationMain(rule: .enable).cliArguments
		#expect(args == ["--enable", "applicationMain"])
	}
}
