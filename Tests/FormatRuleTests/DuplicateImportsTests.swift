//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("duplicateImports")
struct DuplicateImportsTests {

    @Test("duplicateImports .disable 返空陣列")
    func duplicateImportsDisable() {
        let args = FormatRule.duplicateImports(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("duplicateImports .enable 展開 --enable duplicateImports")
    func duplicateImportsEnable() {
        let args = FormatRule.duplicateImports(rule: .enable).cliArguments
        #expect(args == ["--enable", "duplicateImports"])
    }
}
