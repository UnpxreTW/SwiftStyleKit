//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("trailingCommas")
private struct TrailingCommasTests {

	@Test
	private func `trailingCommas .disable 返空陣列`() {
		#expect(FormatRule.trailingCommas(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `trailingCommas .enable 簽名預設展開 --trailingCommas never`() {
		let args = FormatRule.trailingCommas(rule: .enable).cliArguments
		#expect(args == ["--enable", "trailingCommas", "--trailingCommas", "never"])
	}

	@Test
	private func `trailingCommas .enable mode .collectionsOnly 展開 --trailingCommas collections-only`() {
		let args = FormatRule.trailingCommas(rule: .enable, mode: .collectionsOnly).cliArguments
		#expect(args == ["--enable", "trailingCommas", "--trailingCommas", "collections-only"])
	}

	@Test
	private func `trailingCommas .enable mode .always 展開 --trailingCommas always`() {
		let args = FormatRule.trailingCommas(rule: .enable, mode: .always).cliArguments
		#expect(args == ["--enable", "trailingCommas", "--trailingCommas", "always"])
	}

	@Test
	private func `trailingCommas .enable mode .multiElementLists 展開 --trailingCommas multi-element-lists`() {
		let args = FormatRule.trailingCommas(rule: .enable, mode: .multiElementLists).cliArguments
		#expect(args == ["--enable", "trailingCommas", "--trailingCommas", "multi-element-lists"])
	}
}
