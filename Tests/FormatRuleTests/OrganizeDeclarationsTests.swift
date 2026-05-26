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
private struct OrganizeDeclarationsTests {

	@Test
	private func `organizeDeclarations .disable 返空陣列`() {
		#expect(FormatRule.organizeDeclarations(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `organizeDeclarations .enable 簽名預設展開含 visibility/type order 與 thresholds`() {
		let args = FormatRule.organizeDeclarations(rule: .enable).cliArguments
		// 簽名預設包含 organizationMode/visibilityOrder/typeOrder/visibilityMarks/
		// lifecycleMethods/4 個 markThreshold 80/sortSwiftUIProperties/typeBodyMarks
		// markCategories/groupBlankLines
		#expect(args.contains("--enable"))
		#expect(args.contains("organizeDeclarations"))
		#expect(args.contains("--organizationMode"))
		#expect(args.contains("visibility"))
		#expect(args.contains("--visibilityOrder"))
		#expect(args.contains("beforeMarks,open,public,package,instanceLifecycle,internal,fileprivate,private"))
		#expect(args.contains("--typeOrder"))
		#expect(args.contains("--visibilityMarks"))
		#expect(args.contains("fileprivate:File Private"))
		#expect(args.contains("--lifecycle"))
		#expect(args.contains("--markClassThreshold"))
		#expect(args.contains("80"))
		#expect(args.contains("--sortSwiftUIProperties"))
		#expect(args.contains("first-appearance-sort"))
		#expect(args.contains("--typeBodyMarks"))
		#expect(args.contains("remove"))
	}

	@Test
	private func `organizeDeclarations .enable organizationMode .type 展開`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			organizationMode: .type
		).cliArguments
		#expect(args.contains("--organizationMode"))
		#expect(args.contains("type"))
	}

	@Test
	private func `organizeDeclarations .enable 自訂 visibilityOrder 列表展開`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			visibilityOrder: ["beforeMarks", "open", "public", "package", "internal", "fileprivate", "private"]
		).cliArguments
		#expect(args.contains("--visibilityOrder"))
		#expect(args.contains("beforeMarks,open,public,package,internal,fileprivate,private"))
	}

	@Test
	private func `organizeDeclarations .enable classThreshold 20 展開 --classThreshold 20`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			classThreshold: 20
		).cliArguments
		#expect(args.contains("--classThreshold"))
		#expect(args.contains("20"))
	}

	@Test
	private func `organizeDeclarations .enable sortSwiftUIProperties .none 展開`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			sortSwiftUIProperties: .none
		).cliArguments
		#expect(args.contains("--sortSwiftUIProperties"))
		#expect(args.contains("none"))
	}

	@Test
	private func `organizeDeclarations .enable categoryMark template 展開`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			categoryMark: "MARK: == %c =="
		).cliArguments
		#expect(args.contains("--categoryMark"))
		#expect(args.contains("MARK: == %c =="))
	}

	@Test
	private func `organizeDeclarations .enable beforeMarks 空陣列等同 nil 不展開`() {
		let args = FormatRule.organizeDeclarations(
			rule: .enable,
			beforeMarks: []
		).cliArguments
		#expect(!args.contains("--beforeMarks"))
	}
}
