//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("applicationMain")
private struct ApplicationMainTests {

	@Test
	private func `applicationMain .disable 返空陣列`() {
		let args = FormatRule.applicationMain(rule: .disable).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `applicationMain .enable 展開 --enable applicationMain`() {
		let args = FormatRule.applicationMain(rule: .enable).cliArguments
		#expect(args == ["--enable", "applicationMain"])
	}
}
