//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrap")
struct WrapTests {

	@Test
	func `wrap .disable 返空陣列`() {
		#expect(FormatRule.wrap(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `wrap .enable 簽名預設展開 5 option`() {
		let args = FormatRule.wrap(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "wrap",
			"--maxWidth", "120",
			"--assetLiterals", "actual-width",
			"--wrapTernary", "default",
			"--wrapStringInterpolation", "default"
		])
	}

	@Test
	func `wrap .enable maxWidth 改 100`() {
		let args = FormatRule.wrap(rule: .enable, maxWidth: 100).cliArguments
		#expect(args == [
			"--enable", "wrap",
			"--maxWidth", "100",
			"--assetLiterals", "actual-width",
			"--wrapTernary", "default",
			"--wrapStringInterpolation", "default"
		])
	}

	@Test
	func `wrap .enable noWrapOperators 有值展開`() {
		let args = FormatRule.wrap(
			rule: .enable,
			noWrapOperators: [".", "?."]
		).cliArguments
		#expect(args == [
			"--enable", "wrap",
			"--maxWidth", "120",
			"--noWrapOperators", ".,?.",
			"--assetLiterals", "actual-width",
			"--wrapTernary", "default",
			"--wrapStringInterpolation", "default"
		])
	}

	@Test
	func `wrap .enable noWrapOperators 空陣列等同 nil 不展開`() {
		let args = FormatRule.wrap(rule: .enable, noWrapOperators: []).cliArguments
		#expect(args == [
			"--enable", "wrap",
			"--maxWidth", "120",
			"--assetLiterals", "actual-width",
			"--wrapTernary", "default",
			"--wrapStringInterpolation", "default"
		])
	}

	@Test
	func `wrap .enable assetLiterals .visualWidth 展開 visual-width`() {
		let args = FormatRule.wrap(rule: .enable, assetLiterals: .visualWidth).cliArguments
		#expect(args == [
			"--enable", "wrap",
			"--maxWidth", "120",
			"--assetLiterals", "visual-width",
			"--wrapTernary", "default",
			"--wrapStringInterpolation", "default"
		])
	}

	@Test
	func `wrap .enable wrapTernary .beforeOperators 展開`() {
		let args = FormatRule.wrap(rule: .enable, wrapTernary: .beforeOperators).cliArguments
		#expect(args == [
			"--enable", "wrap",
			"--maxWidth", "120",
			"--assetLiterals", "actual-width",
			"--wrapTernary", "before-operators",
			"--wrapStringInterpolation", "default"
		])
	}

	@Test
	func `wrap .enable wrapStringInterpolation .preserve 展開`() {
		let args = FormatRule.wrap(rule: .enable, wrapStringInterpolation: .preserve).cliArguments
		#expect(args == [
			"--enable", "wrap",
			"--maxWidth", "120",
			"--assetLiterals", "actual-width",
			"--wrapTernary", "default",
			"--wrapStringInterpolation", "preserve"
		])
	}
}
