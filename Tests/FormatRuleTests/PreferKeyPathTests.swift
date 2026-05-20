//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferKeyPath")
struct PreferKeyPathTests {

	@Test("preferKeyPath .disable 返空陣列")
	func preferKeyPathDisable() {
		#expect(FormatRule.preferKeyPath(rule: .disable).cliArguments.isEmpty)
	}

	@Test("preferKeyPath .enable 展開 --enable preferKeyPath")
	func preferKeyPathEnable() {
		let args = FormatRule.preferKeyPath(rule: .enable).cliArguments
		#expect(args == ["--enable", "preferKeyPath"])
	}
}
