//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("acronyms")
struct AcronymsTests {

	@Test("acronyms .disable 返空陣列（Xcode 入口已注入 --disable all、不出冗餘 args）")
	func acronymsDisable() {
		let args = FormatRule.acronyms(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("acronyms .enable 展開 --enable acronyms 並帶 --acronyms 預設清單")
	func acronymsEnable() {
		let args = FormatRule.acronyms(rule: .enable).cliArguments
		#expect(args.count == 4)
		#expect(args[0] == "--enable")
		#expect(args[1] == "acronyms")
		#expect(args[2] == "--acronyms")
		#expect(!args[3].isEmpty)
		#expect(args[3].contains("URL"))
	}
}
