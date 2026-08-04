//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("consistentSwitchCaseSpacing")
private struct ConsistentSwitchCaseSpacingTests {

	@Test
	private func `consistentSwitchCaseSpacing .disable 返空陣列`() {
		let args = FormatRule.consistentSwitchCaseSpacing(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `consistentSwitchCaseSpacing .enable 展開 --enable consistentSwitchCaseSpacing`() {
		let args = FormatRule.consistentSwitchCaseSpacing(.on).cliArguments
		#expect(args == ["--enable", "consistentSwitchCaseSpacing"])
	}
}
