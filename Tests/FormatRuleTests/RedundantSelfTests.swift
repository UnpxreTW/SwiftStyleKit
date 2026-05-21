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
struct RedundantSelfTests {

	@Test("redundantSelf .disable 返空陣列")
	func redundantSelfDisable() {
		let args = FormatRule.redundantSelf(rule: .disable, mode: .initOnly).cliArguments
		#expect(args.isEmpty)
	}

	@Test("redundantSelf .enable（預設 .initOnly、selfRequired nil）展開 --enable + --self init-only")
	func redundantSelfEnableDefault() {
		let args = FormatRule.redundantSelf(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "redundantSelf",
			"--self", "init-only"
		])
	}

	@Test("redundantSelf .enable mode .remove 展開 --self remove")
	func redundantSelfEnableRemove() {
		let args = FormatRule.redundantSelf(rule: .enable, mode: .remove).cliArguments
		#expect(args == [
			"--enable", "redundantSelf",
			"--self", "remove"
		])
	}

	@Test("redundantSelf .enable mode .insert 展開 --self insert")
	func redundantSelfEnableInsert() {
		let args = FormatRule.redundantSelf(rule: .enable, mode: .insert).cliArguments
		#expect(args == [
			"--enable", "redundantSelf",
			"--self", "insert"
		])
	}

	@Test("redundantSelf .enable 帶 selfRequired 展開 --selfRequired <清單>")
	func redundantSelfEnableSelfRequired() {
		let args = FormatRule.redundantSelf(
			rule: .enable,
			mode: .initOnly,
			selfRequired: "expect,require"
		).cliArguments
		#expect(args == [
			"--enable", "redundantSelf",
			"--self", "init-only",
			"--selfRequired", "expect,require"
		])
	}
}
