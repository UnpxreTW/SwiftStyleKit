//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapArguments")
private struct WrapArgumentsTests {

	@Test
	private func `wrapArguments .disable 返空陣列`() {
		#expect(FormatRule.wrapArguments(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapArguments .enable 簽名預設展開 10 option（wrapStringInterpolation 已抽出全域）`() {
		let args = FormatRule.wrapArguments(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "wrapArguments",
			"--wrapArguments", "preserve",
			"--wrapParameters", "before-first",
			"--wrapCollections", "preserve",
			"--wrapConditions", "preserve",
			"--wrapTypeAliases", "preserve",
			"--wrapEffects", "preserve",
			"--wrapReturnType", "preserve",
			"--closingParen", "balanced",
			"--callSiteParen", "balanced",
			"--allowPartialWrapping", "true"
		])
	}

	@Test
	private func `wrapArguments .enable wrapArguments .beforeFirst 展開`() {
		let args = FormatRule.wrapArguments(
			rule: .enable,
			wrapArguments: .beforeFirst
		)
		.cliArguments
		#expect(args.contains("--wrapArguments"))
		#expect(args.contains("before-first"))
	}

	@Test
	private func `wrapArguments .enable wrapEffects .ifMultiline 展開`() {
		let args = FormatRule.wrapArguments(
			rule: .enable,
			wrapEffects: .ifMultiline
		)
		.cliArguments
		#expect(args.contains("--wrapEffects"))
		#expect(args.contains("if-multiline"))
	}

	@Test
	private func `wrapArguments .enable closingParen .sameLine 展開`() {
		let args = FormatRule.wrapArguments(
			rule: .enable,
			closingParen: .sameLine
		)
		.cliArguments
		#expect(args.contains("--closingParen"))
		#expect(args.contains("same-line"))
	}

	@Test
	private func `wrapArguments .enable allowPartialWrapping .disable 展開 false`() {
		let args = FormatRule.wrapArguments(
			rule: .enable,
			allowPartialWrapping: .disable
		)
		.cliArguments
		#expect(args.contains("--allowPartialWrapping"))
		#expect(args.contains("false"))
	}
}
