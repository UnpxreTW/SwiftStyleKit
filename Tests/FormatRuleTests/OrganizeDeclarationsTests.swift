//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("organizeDeclarations")
struct OrganizeDeclarationsTests {

	@Test
	func `organizeDeclarations .disable 返空陣列`() {
		#expect(FormatRule.organizeDeclarations(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	func `organizeDeclarations .enable 簽名預設展開 5 個必要 option`() {
		let args = FormatRule.organizeDeclarations(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "organizeDeclarations",
			"--organizationMode", "visibility",
			"--markCategories", "true",
			"--sortSwiftUIProperties", "none",
			"--typeBodyMarks", "preserve",
			"--groupBlankLines", "true"
		])
	}

	@Test
	func `organizeDeclarations .enable organizationMode .type 展開`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			organizationMode: .type
		).cliArguments
		#expect(args.contains("--organizationMode"))
		#expect(args.contains("type"))
	}

	@Test
	func `organizeDeclarations .enable visibilityOrder 列表展開`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			visibilityOrder: ["beforeMarks", "instanceLifecycle", "public", "internal", "fileprivate", "private"]
		).cliArguments
		#expect(args.contains("--visibilityOrder"))
		#expect(args.contains("beforeMarks,instanceLifecycle,public,internal,fileprivate,private"))
	}

	@Test
	func `organizeDeclarations .enable classThreshold 20 展開 --classThreshold 20`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			classThreshold: 20
		).cliArguments
		#expect(args.contains("--classThreshold"))
		#expect(args.contains("20"))
	}

	@Test
	func `organizeDeclarations .enable sortSwiftUIProperties .firstAppearanceSort 展開`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			sortSwiftUIProperties: .firstAppearanceSort
		).cliArguments
		#expect(args.contains("--sortSwiftUIProperties"))
		#expect(args.contains("first-appearance-sort"))
	}

	@Test
	func `organizeDeclarations .enable categoryMark template 展開`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			categoryMark: "MARK: == %c =="
		).cliArguments
		#expect(args.contains("--categoryMark"))
		#expect(args.contains("MARK: == %c =="))
	}

	@Test
	func `organizeDeclarations .enable beforeMarks 空陣列等同 nil 不展開`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			beforeMarks: []
		).cliArguments
		#expect(!args.contains("--beforeMarks"))
	}
}
