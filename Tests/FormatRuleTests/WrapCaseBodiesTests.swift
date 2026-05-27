//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapCaseBodies")
private struct WrapCaseBodiesTests {

	@Test
	private func `wrapCaseBodies .disable 返空陣列`() {
		#expect(FormatRule.wrapCaseBodies(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapCaseBodies .enable 只 enable 不展開 option`() {
		#expect(FormatRule.wrapCaseBodies(rule: .enable).cliArguments == ["--enable", "wrapCaseBodies"])
	}
}
