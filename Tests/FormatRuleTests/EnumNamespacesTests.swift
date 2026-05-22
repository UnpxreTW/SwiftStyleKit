//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("enumNamespaces")
struct EnumNamespacesTests {

	@Test
	func `enumNamespaces .disable 返空陣列`() {
		let args = FormatRule.enumNamespaces(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `enumNamespaces .disable + mode（option 被忽略）返空陣列`() {
		let args = FormatRule.enumNamespaces(rule: .disable, mode: .structsOnly).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `enumNamespaces .enable（mode 預設 .always）展開 --enable + --enumNamespaces always`() {
		let args = FormatRule.enumNamespaces(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "enumNamespaces",
			"--enumNamespaces", "always",
		])
	}

	@Test
	func `enumNamespaces .enable mode .structsOnly 展開 --enumNamespaces structs-only`() {
		let args = FormatRule.enumNamespaces(rule: .enable, mode: .structsOnly).cliArguments
		#expect(args == [
			"--enable", "enumNamespaces",
			"--enumNamespaces", "structs-only",
		])
	}
}
