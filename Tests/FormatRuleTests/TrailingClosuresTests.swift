//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("trailingClosures")
private struct TrailingClosuresTests {

	@Test
	private func `trailingClosures .disable 返空陣列`() {
		#expect(FormatRule.trailingClosures(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `trailingClosures .enable 簽名預設兩 option 皆 nil 不展開`() {
		let args = FormatRule.trailingClosures(rule: .enable).cliArguments
		#expect(args == ["--enable", "trailingClosures"])
	}

	@Test
	private func `trailingClosures .enable + trailingClosures 列表展開逗號相連`() {
		let args = FormatRule.trailingClosures(
			rule: .enable,
			trailingClosures: ["withAnimation", "UIView.animate"]
		)
		.cliArguments
		#expect(args == [
			"--enable", "trailingClosures",
			"--trailingClosures", "withAnimation,UIView.animate"
		])
	}

	@Test
	private func `trailingClosures .enable + neverTrailing 列表展開`() {
		let args = FormatRule.trailingClosures(
			rule: .enable,
			neverTrailing: ["customExpect"]
		)
		.cliArguments
		#expect(args == [
			"--enable", "trailingClosures",
			"--neverTrailing", "customExpect"
		])
	}

	@Test
	private func `trailingClosures .enable + 空陣列等同 nil 不展開`() {
		let args = FormatRule.trailingClosures(
			rule: .enable,
			trailingClosures: [],
			neverTrailing: []
		)
		.cliArguments
		#expect(args == ["--enable", "trailingClosures"])
	}
}
