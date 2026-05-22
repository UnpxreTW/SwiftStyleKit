//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("extensionAccessControl")
struct ExtensionAccessControlTests {

	@Test
	func `extensionAccessControl .disable 返空陣列`() {
		let args = FormatRule.extensionAccessControl(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `extensionAccessControl .disable + mode（option 被忽略）返空陣列`() {
		let args = FormatRule.extensionAccessControl(rule: .disable, mode: .onExtension).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	func `extensionAccessControl .enable（mode 預設 .onDeclarations）展開 --enable + --extensionAcl on-declarations`() {
		let args = FormatRule.extensionAccessControl(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "extensionAccessControl",
			"--extensionAcl", "on-declarations",
		])
	}

	@Test
	func `extensionAccessControl .enable mode .onExtension 展開 --extensionAcl on-extension`() {
		let args = FormatRule.extensionAccessControl(rule: .enable, mode: .onExtension).cliArguments
		#expect(args == [
			"--enable", "extensionAccessControl",
			"--extensionAcl", "on-extension",
		])
	}
}
