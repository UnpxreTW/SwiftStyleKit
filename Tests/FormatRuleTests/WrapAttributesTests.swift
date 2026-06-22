//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapAttributes")
private struct WrapAttributesTests {

	@Test
	private func `wrapAttributes .disable 返空陣列`() {
		#expect(FormatRule.wrapAttributes(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapAttributes .enable 簽名預設展開 5 attribute mode 全 prev-line`() {
		let args = FormatRule.wrapAttributes(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "wrapAttributes",
			"--funcAttributes", "prev-line",
			"--typeAttributes", "prev-line",
			"--storedVarAttributes", "prev-line",
			"--computedVarAttributes", "prev-line",
			"--complexAttributes", "prev-line"
		])
	}

	@Test
	private func `wrapAttributes .enable funcAttributes .sameLine 展開`() {
		let args = FormatRule.wrapAttributes(
			rule: .enable,
			funcAttributes: .sameLine
		)
		.cliArguments
		#expect(args.contains("--funcAttributes"))
		#expect(args.contains("same-line"))
	}

	@Test
	private func `wrapAttributes .enable complexAttributes .preserve 展開`() {
		let args = FormatRule.wrapAttributes(
			rule: .enable,
			complexAttributes: .preserve
		)
		.cliArguments
		#expect(args.contains("--complexAttributes"))
		#expect(args.contains("preserve"))
	}

	@Test
	private func `wrapAttributes .enable nonComplexAttributes 有值展開逗號相連`() {
		let args = FormatRule.wrapAttributes(
			rule: .enable,
			nonComplexAttributes: ["objc", "available"]
		)
		.cliArguments
		#expect(args.contains("--nonComplexAttributes"))
		#expect(args.contains("objc,available"))
	}

	@Test
	private func `wrapAttributes .enable nonComplexAttributes 空陣列等同 nil 不展開`() {
		let args = FormatRule.wrapAttributes(
			rule: .enable,
			nonComplexAttributes: []
		)
		.cliArguments
		#expect(!args.contains("--nonComplexAttributes"))
	}
}
