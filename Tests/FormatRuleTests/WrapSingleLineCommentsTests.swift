//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("wrapSingleLineComments")
private struct WrapSingleLineCommentsTests {

	@Test
	private func `wrapSingleLineComments .disable 返空陣列`() {
		#expect(FormatRule.wrapSingleLineComments(rule: .disable).cliArguments.isEmpty)
	}

	@Test
	private func `wrapSingleLineComments .enable 展開 --enable wrapSingleLineComments`() {
		let args = FormatRule.wrapSingleLineComments(rule: .enable).cliArguments
		#expect(args == ["--enable", "wrapSingleLineComments"])
	}
}
