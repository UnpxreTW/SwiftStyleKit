//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("redundantSelf")
private struct RedundantSelfTests {

	@Test
	private func `redundantSelf .disable 返空陣列`() {
		let args = FormatRule.redundantSelf(rule: .disable, mode: .initOnly).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `redundantSelf .enable（預設 .initOnly、selfRequired nil）展開 --enable + --self init-only`() {
		let args = FormatRule.redundantSelf(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "redundantSelf",
			"--self", "init-only"
		])
	}

	@Test
	private func `redundantSelf .enable mode .remove 展開 --self remove`() {
		let args = FormatRule.redundantSelf(rule: .enable, mode: .remove).cliArguments
		#expect(args == [
			"--enable", "redundantSelf",
			"--self", "remove"
		])
	}

	@Test
	private func `redundantSelf .enable mode .insert 展開 --self insert`() {
		let args = FormatRule.redundantSelf(rule: .enable, mode: .insert).cliArguments
		#expect(args == [
			"--enable", "redundantSelf",
			"--self", "insert"
		])
	}

	@Test
	private func `redundantSelf .enable 帶 selfRequired 展開 --selfRequired <清單>`() {
		let args = FormatRule.redundantSelf(
			rule: .enable,
			mode: .initOnly,
			selfRequired: "expect,require"
		)
		.cliArguments
		#expect(args == [
			"--enable", "redundantSelf",
			"--self", "init-only",
			"--selfRequired", "expect,require"
		])
	}
}
