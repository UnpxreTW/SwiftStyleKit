//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesAroundMark")
struct BlankLinesAroundMarkTests {

    @Test("blankLinesAroundMark .disable 返空陣列")
    func blankLinesAroundMarkDisable() {
        let args = FormatRule.blankLinesAroundMark(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLinesAroundMark .disable + lineAfterMarks（option 被忽略）返空陣列")
    func blankLinesAroundMarkDisableWithOption() {
        let args = FormatRule.blankLinesAroundMark(rule: .disable, lineAfterMarks: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLinesAroundMark .enable（lineAfterMarks 預設 .enable）展開 --enable + --lineAfterMarks true")
    func blankLinesAroundMarkEnableDefault() {
        let args = FormatRule.blankLinesAroundMark(rule: .enable).cliArguments
        #expect(args == [
            "--enable", "blankLinesAroundMark",
            "--lineAfterMarks", "true"
        ])
    }

    @Test("blankLinesAroundMark .enable lineAfterMarks .disable 展開 --lineAfterMarks false")
    func blankLinesAroundMarkEnableLineAfterMarksDisable() {
        let args = FormatRule.blankLinesAroundMark(rule: .enable, lineAfterMarks: .disable).cliArguments
        #expect(args == [
            "--enable", "blankLinesAroundMark",
            "--lineAfterMarks", "false"
        ])
    }
}
