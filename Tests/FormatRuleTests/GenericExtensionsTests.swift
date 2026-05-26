//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("genericExtensions")
private struct GenericExtensionsTests {

	@Test
	private func `genericExtensions .disable 返空陣列`() {
		let args = FormatRule.genericExtensions(rule: .disable, genericTypes: "Foo<Bar>").cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `genericExtensions .enable（genericTypes 預設 nil）只展開 --enable`() {
		let args = FormatRule.genericExtensions(rule: .enable).cliArguments
		#expect(args == ["--enable", "genericExtensions"])
	}

	@Test
	private func `genericExtensions .enable genericTypes 有值展開 --genericTypes`() {
		let args = FormatRule.genericExtensions(rule: .enable, genericTypes: "LinkedList<Element>").cliArguments
		#expect(args == [
			"--enable", "genericExtensions",
			"--genericTypes", "LinkedList<Element>"
		])
	}
}
