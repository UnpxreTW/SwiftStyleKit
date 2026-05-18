//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("emptyExtensions")
struct EmptyExtensionsTests {

    @Test("emptyExtensions .disable 返空陣列")
    func emptyExtensionsDisable() {
        let args = FormatRule.emptyExtensions(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("emptyExtensions .enable 展開 --enable emptyExtensions")
    func emptyExtensionsEnable() {
        let args = FormatRule.emptyExtensions(rule: .enable).cliArguments
        #expect(args == ["--enable", "emptyExtensions"])
    }
}
