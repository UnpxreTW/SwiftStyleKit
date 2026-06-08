//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("propertyTypes")
private struct PropertyTypesTests {

	@Test
	private func `propertyTypes .disable 返空陣列`() {
		#expect(FormatRule.propertyTypes(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `propertyTypes .enable 簽名預設展開 2 option`() {
		let args = FormatRule.propertyTypes(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "propertyTypes",
			"--propertyTypes", "explicit",
			"--inferredTypes", "always"
		])
	}

	@Test
	private func `propertyTypes .enable propertyTypes .inferred 展開`() {
		let args = FormatRule.propertyTypes(rule: .enable, propertyTypes: .inferred).cliArguments
		#expect(args.contains("--propertyTypes"))
		#expect(args.contains("inferred"))
	}

	@Test
	private func `propertyTypes .enable inferredTypes .excludeCondExprs 展開`() {
		let args = FormatRule.propertyTypes(rule: .enable, inferredTypes: .excludeCondExprs).cliArguments
		#expect(args.contains("--inferredTypes"))
		#expect(args.contains("exclude-cond-exprs"))
	}

	@Test
	private func `propertyTypes .enable preservedPropertyTypes 自訂展開`() {
		let args = FormatRule.propertyTypes(
			rule: .enable,
			preservedPropertyTypes: ["Package", "MyCustom"]
		)
		.cliArguments
		#expect(args.contains("--preservedPropertyTypes"))
		#expect(args.contains("Package,MyCustom"))
	}
}
