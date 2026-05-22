//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantType")
struct RedundantTypeTests {

	@Test
	func `redundantType .disable 返空陣列`() {
		let args = FormatRule.redundantType(rule: .disable, mode: .explicit).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `redundantType .enable（預設 .explicit）展開 --enable + --redundantType explicit`() {
		let args = FormatRule.redundantType(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "redundantType",
			"--redundantType", "explicit",
		])
	}

	@Test
	func `redundantType .enable mode .inferred 展開 --redundantType inferred`() {
		let args = FormatRule.redundantType(rule: .enable, mode: .inferred).cliArguments
		#expect(args == [
			"--enable", "redundantType",
			"--redundantType", "inferred",
		])
	}

	@Test
	func `redundantType .enable mode .inferLocalsOnly 展開 --redundantType infer-locals-only`() {
		let args = FormatRule.redundantType(rule: .enable, mode: .inferLocalsOnly).cliArguments
		#expect(args == [
			"--enable", "redundantType",
			"--redundantType", "infer-locals-only",
		])
	}
}
