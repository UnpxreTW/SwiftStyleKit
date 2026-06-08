//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapStringInterpolation")
private struct WrapStringInterpolationTests {

	@Test
	private func `wrapStringInterpolation 簽名預設展開 --wrapStringInterpolation default`() {
		let args = FormatRule.wrapStringInterpolation().cliArguments
		#expect(args == ["--wrapStringInterpolation", "default"])
	}

	@Test
	private func `wrapStringInterpolation mode .preserve 展開`() {
		let args = FormatRule.wrapStringInterpolation(mode: .preserve).cliArguments
		#expect(args == ["--wrapStringInterpolation", "preserve"])
	}

	@Test
	private func `wrapStringInterpolation mode nil 不展開`() {
		let args = FormatRule.wrapStringInterpolation(mode: nil).cliArguments
		#expect(args.isEmpty)
	}
}
