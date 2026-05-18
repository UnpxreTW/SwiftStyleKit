//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("consecutiveBlankLines")
struct ConsecutiveBlankLinesTests {

    @Test("consecutiveBlankLines .disable 返空陣列")
    func consecutiveBlankLinesDisable() {
        let args = FormatRule.consecutiveBlankLines(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("consecutiveBlankLines .enable 展開 --enable consecutiveBlankLines")
    func consecutiveBlankLinesEnable() {
        let args = FormatRule.consecutiveBlankLines(rule: .enable).cliArguments
        #expect(args == ["--enable", "consecutiveBlankLines"])
    }
}
