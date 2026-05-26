//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("opaqueGenericParameters")
private struct OpaqueGenericParametersTests {

	@Test
	private func `opaqueGenericParameters .disable 返空陣列`() {
		let args = FormatRule.opaqueGenericParameters(rule: .disable, someAny: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `opaqueGenericParameters .enable（someAny 預設 .enable）展開 --enable + --someAny true`() {
		let args = FormatRule.opaqueGenericParameters(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "opaqueGenericParameters",
			"--someAny", "true"
		])
	}

	@Test
	private func `opaqueGenericParameters .enable someAny .disable 展開 --someAny false`() {
		let args = FormatRule.opaqueGenericParameters(rule: .enable, someAny: .disable).cliArguments
		#expect(args == [
			"--enable", "opaqueGenericParameters",
			"--someAny", "false"
		])
	}
}
