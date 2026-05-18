//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("genericExtensions")
struct GenericExtensionsTests {

    @Test("genericExtensions .disable 返空陣列")
    func genericExtensionsDisable() {
        let args = FormatRule.genericExtensions(rule: .disable, genericTypes: "Foo<Bar>").cliArguments
        #expect(args.isEmpty)
    }

    @Test("genericExtensions .enable（genericTypes 預設 nil）只展開 --enable")
    func genericExtensionsEnableDefault() {
        let args = FormatRule.genericExtensions(rule: .enable).cliArguments
        #expect(args == ["--enable", "genericExtensions"])
    }

    @Test("genericExtensions .enable genericTypes 有值展開 --genericTypes")
    func genericExtensionsEnableWithTypes() {
        let args = FormatRule.genericExtensions(rule: .enable, genericTypes: "LinkedList<Element>").cliArguments
        #expect(args == [
            "--enable", "genericExtensions",
            "--genericTypes", "LinkedList<Element>"
        ])
    }
}
