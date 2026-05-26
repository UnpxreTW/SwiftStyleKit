//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("propertyTypes")
struct PropertyTypesTests {

	@Test
	func `propertyTypes .disable 返空陣列`() {
		#expect(FormatRule.propertyTypes(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `propertyTypes .enable 簽名預設展開 3 option`() {
		let args = FormatRule.propertyTypes(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "propertyTypes",
			"--propertyTypes", "infer-locals-only",
			"--inferredTypes", "always",
			"--preservedPropertyTypes", "Package"
		])
	}

	@Test
	func `propertyTypes .enable propertyTypes .inferred 展開`() {
		let args = FormatRule.propertyTypes(rule: .enable, propertyTypes: .inferred).cliArguments
		#expect(args.contains("--propertyTypes"))
		#expect(args.contains("inferred"))
	}

	@Test
	func `propertyTypes .enable inferredTypes .excludeCondExprs 展開`() {
		let args = FormatRule.propertyTypes(rule: .enable, inferredTypes: .excludeCondExprs).cliArguments
		#expect(args.contains("--inferredTypes"))
		#expect(args.contains("exclude-cond-exprs"))
	}

	@Test
	func `propertyTypes .enable preservedPropertyTypes 自訂展開`() {
		let args = FormatRule.propertyTypes(
			rule: .enable,
			preservedPropertyTypes: ["Package", "MyCustom"]
		).cliArguments
		#expect(args.contains("--preservedPropertyTypes"))
		#expect(args.contains("Package,MyCustom"))
	}
}
