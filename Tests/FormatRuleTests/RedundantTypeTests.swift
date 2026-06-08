//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantType")
private struct RedundantTypeTests {

	@Test
	private func `redundantType .disable 返空陣列`() {
		let args = FormatRule.redundantType(rule: .disable, mode: .explicit).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `redundantType .enable（預設 .explicit）展開 --enable + --redundantType explicit`() {
		let args = FormatRule.redundantType(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "redundantType",
			"--redundantType", "explicit"
		])
	}

	@Test
	private func `redundantType .enable mode .inferred 展開 --redundantType inferred`() {
		let args = FormatRule.redundantType(rule: .enable, mode: .inferred).cliArguments
		#expect(args == [
			"--enable", "redundantType",
			"--redundantType", "inferred"
		])
	}

	@Test
	private func `redundantType .enable mode .inferLocalsOnly 展開 --redundantType infer-locals-only`() {
		let args = FormatRule.redundantType(rule: .enable, mode: .inferLocalsOnly).cliArguments
		#expect(args == [
			"--enable", "redundantType",
			"--redundantType", "infer-locals-only"
		])
	}
}
