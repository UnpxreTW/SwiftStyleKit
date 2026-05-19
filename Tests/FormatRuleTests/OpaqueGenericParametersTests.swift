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
struct OpaqueGenericParametersTests {

	@Test("opaqueGenericParameters .disable 返空陣列")
	func opaqueGenericParametersDisable() {
		let args = FormatRule.opaqueGenericParameters(rule: .disable, someAny: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test("opaqueGenericParameters .enable（someAny 預設 .enable）展開 --enable + --someAny true")
	func opaqueGenericParametersEnableDefault() {
		let args = FormatRule.opaqueGenericParameters(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "opaqueGenericParameters",
			"--someAny", "true"
		])
	}

	@Test("opaqueGenericParameters .enable someAny .disable 展開 --someAny false")
	func opaqueGenericParametersEnableSomeAnyDisable() {
		let args = FormatRule.opaqueGenericParameters(rule: .enable, someAny: .disable).cliArguments
		#expect(args == [
			"--enable", "opaqueGenericParameters",
			"--someAny", "false"
		])
	}
}
