//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("hoistAwait")
struct HoistAwaitTests {

    @Test("hoistAwait .disable 返空陣列")
    func hoistAwaitDisable() {
        let args = FormatRule.hoistAwait(rule: .disable, asyncCapturing: "foo").cliArguments
        #expect(args.isEmpty)
    }

    @Test("hoistAwait .enable（asyncCapturing 預設 nil）只展開 --enable")
    func hoistAwaitEnableDefault() {
        let args = FormatRule.hoistAwait(rule: .enable).cliArguments
        #expect(args == ["--enable", "hoistAwait"])
    }

    @Test("hoistAwait .enable asyncCapturing 有值展開 --asyncCapturing")
    func hoistAwaitEnableWithCapturing() {
        let args = FormatRule.hoistAwait(rule: .enable, asyncCapturing: "withChecked").cliArguments
        #expect(args == [
            "--enable", "hoistAwait",
            "--asyncCapturing", "withChecked"
        ])
    }
}
