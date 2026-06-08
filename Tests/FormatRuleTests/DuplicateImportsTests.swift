//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("duplicateImports")
private struct DuplicateImportsTests {

	@Test
	private func `duplicateImports .disable 返空陣列`() {
		let args = FormatRule.duplicateImports(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `duplicateImports .enable 展開 --enable duplicateImports`() {
		let args = FormatRule.duplicateImports(rule: .enable).cliArguments
		#expect(args == ["--enable", "duplicateImports"])
	}
}
