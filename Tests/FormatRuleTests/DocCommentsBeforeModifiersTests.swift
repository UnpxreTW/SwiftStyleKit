//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("docCommentsBeforeModifiers")
struct DocCommentsBeforeModifiersTests {

    @Test("docCommentsBeforeModifiers .disable 返空陣列")
    func docCommentsBeforeModifiersDisable() {
        let args = FormatRule.docCommentsBeforeModifiers(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("docCommentsBeforeModifiers .enable 展開 --enable docCommentsBeforeModifiers")
    func docCommentsBeforeModifiersEnable() {
        let args = FormatRule.docCommentsBeforeModifiers(rule: .enable).cliArguments
        #expect(args == ["--enable", "docCommentsBeforeModifiers"])
    }
}
