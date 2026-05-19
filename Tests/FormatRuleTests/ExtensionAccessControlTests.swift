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

	@Test("extensionAccessControl .disable 返空陣列")
	func extensionAccessControlDisable() {
		let args = FormatRule.extensionAccessControl(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("extensionAccessControl .disable + mode（option 被忽略）返空陣列")
	func extensionAccessControlDisableWithMode() {
		let args = FormatRule.extensionAccessControl(rule: .disable, mode: .onExtension).cliArguments
		#expect(args.isEmpty)
	}

	@Test("extensionAccessControl .enable（mode 預設 .onDeclarations）展開 --enable + --extensionAcl on-declarations")
	func extensionAccessControlEnableDefault() {
		let args = FormatRule.extensionAccessControl(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "extensionAccessControl",
			"--extensionAcl", "on-declarations"
		])
	}

	@Test("extensionAccessControl .enable mode .onExtension 展開 --extensionAcl on-extension")
	func extensionAccessControlEnableOnExtension() {
		let args = FormatRule.extensionAccessControl(rule: .enable, mode: .onExtension).cliArguments
		#expect(args == [
			"--enable", "extensionAccessControl",
			"--extensionAcl", "on-extension"
		])
	}
}
