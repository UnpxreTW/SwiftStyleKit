//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("preferSwiftTesting")
private struct PreferSwiftTestingTests {

	@Test
	private func `preferSwiftTesting .disable 返空陣列`() {
		#expect(FormatRule.preferSwiftTesting(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `preferSwiftTesting .enable 簽名預設兩 option 皆 nil 不展開`() {
		let args = FormatRule.preferSwiftTesting(rule: .enable).cliArguments
		#expect(args == ["--enable", "preferSwiftTesting"])
	}

	@Test
	private func `preferSwiftTesting .enable defaultTestSuiteAttributes 有值展開`() {
		let args = FormatRule.preferSwiftTesting(
			rule: .enable,
			defaultTestSuiteAttributes: ["@MainActor", "@Suite(.serialized)"]
		).cliArguments
		#expect(args.contains("--defaultTestSuiteAttributes"))
		#expect(args.contains("@MainActor,@Suite(.serialized)"))
	}

	@Test
	private func `preferSwiftTesting .enable xctestSymbols 有值展開`() {
		let args = FormatRule.preferSwiftTesting(
			rule: .enable,
			xctestSymbols: ["CustomTestHelper"]
		).cliArguments
		#expect(args.contains("--xctestSymbols"))
		#expect(args.contains("CustomTestHelper"))
	}
}
