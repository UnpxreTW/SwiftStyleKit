//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("extensionAccessControl")
private struct ExtensionAccessControlTests {

	@Test
	private func `extensionAccessControl .disable 返空陣列`() {
		let args = FormatRule.extensionAccessControl(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `extensionAccessControl .enable（mode 預設 .onDeclarations）展開 --enable + --extensionAcl on-declarations`() {
		let args = FormatRule.extensionAccessControl(.on).cliArguments
		#expect(args == [
			"--enable", "extensionAccessControl",
			"--extensionAcl", "on-declarations"
		])
	}

	@Test
	private func `extensionAccessControl .enable mode .onExtension 展開 --extensionAcl on-extension`() {
		let args = FormatRule.extensionAccessControl(.on, mode: .onExtension).cliArguments
		#expect(args == [
			"--enable", "extensionAccessControl",
			"--extensionAcl", "on-extension"
		])
	}
}
