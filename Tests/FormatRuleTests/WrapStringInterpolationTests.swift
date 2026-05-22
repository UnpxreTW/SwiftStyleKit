//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapStringInterpolation")
struct WrapStringInterpolationTests {

	@Test
	func `wrapStringInterpolation 簽名預設展開 --wrapStringInterpolation default`() {
		let args = FormatRule.wrapStringInterpolation().cliArguments
		#expect(args == ["--wrapStringInterpolation", "default"])
	}

	@Test
	func `wrapStringInterpolation mode .preserve 展開`() {
		let args = FormatRule.wrapStringInterpolation(mode: .preserve).cliArguments
		#expect(args == ["--wrapStringInterpolation", "preserve"])
	}

	@Test
	func `wrapStringInterpolation mode nil 不展開`() {
		let args = FormatRule.wrapStringInterpolation(mode: nil).cliArguments
		#expect(args.isEmpty)
	}
}
