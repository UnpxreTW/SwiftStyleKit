//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

    /// ``FormatRule/enumNamespaces(rule:mode:)`` 轉換命名空間型別的範圍
    ///
    /// 對應 swiftformat 的 `enum-namespaces` option。
    public enum EnumNamespacesMode: String, FormatRuleOption {

        /// 對應的 swiftformat CLI option flag 名稱
        public static let flagName = "enumNamespaces"

        /// `struct` 與 `final class` 命名空間都轉成 `enum`（swiftformat 上游預設）
        case always

        /// 只轉 `struct`、`final class` 命名空間保留不動
        case structsOnly = "structs-only"
    }
}
