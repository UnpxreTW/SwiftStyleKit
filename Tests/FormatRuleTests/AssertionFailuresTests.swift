//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("assertionFailures")
struct AssertionFailuresTests {

    @Test("assertionFailures .disable 返空陣列")
    func assertionFailuresDisable() {
        let args = FormatRule.assertionFailures(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("assertionFailures .enable 展開 --enable assertionFailures")
    func assertionFailuresEnable() {
        let args = FormatRule.assertionFailures(rule: .enable).cliArguments
        #expect(args == ["--enable", "assertionFailures"])
    }
}
