//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("consistentSwitchCaseSpacing")
struct ConsistentSwitchCaseSpacingTests {

    @Test("consistentSwitchCaseSpacing .disable 返空陣列")
    func consistentSwitchCaseSpacingDisable() {
        let args = FormatRule.consistentSwitchCaseSpacing(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("consistentSwitchCaseSpacing .enable 展開 --enable consistentSwitchCaseSpacing")
    func consistentSwitchCaseSpacingEnable() {
        let args = FormatRule.consistentSwitchCaseSpacing(rule: .enable).cliArguments
        #expect(args == ["--enable", "consistentSwitchCaseSpacing"])
    }
}
