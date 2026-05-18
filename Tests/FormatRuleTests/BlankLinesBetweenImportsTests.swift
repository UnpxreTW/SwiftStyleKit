//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("blankLinesBetweenImports")
struct BlankLinesBetweenImportsTests {

    @Test("blankLinesBetweenImports .disable 返空陣列")
    func blankLinesBetweenImportsDisable() {
        let args = FormatRule.blankLinesBetweenImports(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLinesBetweenImports .enable 展開 --enable blankLinesBetweenImports")
    func blankLinesBetweenImportsEnable() {
        let args = FormatRule.blankLinesBetweenImports(rule: .enable).cliArguments
        #expect(args == ["--enable", "blankLinesBetweenImports"])
    }
}
