//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantVoidReturnType")
struct RedundantVoidReturnTypeTests {

	@Test("redundantVoidReturnType .disable 返空陣列")
	func redundantVoidReturnTypeDisable() {
		let args = FormatRule.redundantVoidReturnType(rule: .disable, closureVoid: .remove).cliArguments
		#expect(args.isEmpty)
	}

	@Test("redundantVoidReturnType .enable（預設 closureVoid .remove）展開 --enable + --closurevoid remove")
	func redundantVoidReturnTypeEnableDefault() {
		let args = FormatRule.redundantVoidReturnType(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "redundantVoidReturnType",
			"--closurevoid", "remove"
		])
	}

	@Test("redundantVoidReturnType .enable closureVoid .preserve 展開 --closurevoid preserve")
	func redundantVoidReturnTypeEnablePreserve() {
		let args = FormatRule.redundantVoidReturnType(rule: .enable, closureVoid: .preserve).cliArguments
		#expect(args == [
			"--enable", "redundantVoidReturnType",
			"--closurevoid", "preserve"
		])
	}
}
