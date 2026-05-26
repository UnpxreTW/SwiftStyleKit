//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferFinalClasses")
struct PreferFinalClassesTests {

	@Test
	func `preferFinalClasses .disable 返空陣列`() {
		#expect(FormatRule.preferFinalClasses(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `preferFinalClasses .enable 展開 --enable preferFinalClasses`() {
		let args = FormatRule.preferFinalClasses(rule: .enable).cliArguments
		#expect(args == ["--enable", "preferFinalClasses"])
	}
}
