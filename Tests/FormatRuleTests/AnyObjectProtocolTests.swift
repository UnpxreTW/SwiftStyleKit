//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("anyObjectProtocol")
struct AnyObjectProtocolTests {

    @Test("anyObjectProtocol .disable 返空陣列")
    func anyObjectProtocolDisable() {
        let args = FormatRule.anyObjectProtocol(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("anyObjectProtocol .enable 展開 --enable anyObjectProtocol")
    func anyObjectProtocolEnable() {
        let args = FormatRule.anyObjectProtocol(rule: .enable).cliArguments
        #expect(args == ["--enable", "anyObjectProtocol"])
    }
}
