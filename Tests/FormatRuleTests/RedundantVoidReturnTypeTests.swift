//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantVoidReturnType")
private struct RedundantVoidReturnTypeTests {

	@Test
	private func `redundantVoidReturnType .disable 返空陣列`() {
		let args = FormatRule.redundantVoidReturnType(rule: .disable, closureVoid: .remove).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `redundantVoidReturnType .enable（預設 closureVoid .remove）展開 --enable + --closurevoid remove`() {
		let args = FormatRule.redundantVoidReturnType(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "redundantVoidReturnType",
			"--closurevoid", "remove"
		])
	}

	@Test
	private func `redundantVoidReturnType .enable closureVoid .preserve 展開 --closurevoid preserve`() {
		let args = FormatRule.redundantVoidReturnType(rule: .enable, closureVoid: .preserve).cliArguments
		#expect(args == [
			"--enable", "redundantVoidReturnType",
			"--closurevoid", "preserve"
		])
	}
}
