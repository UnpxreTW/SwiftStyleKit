//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

    /// ``FormatRule/fileMacro(rule:mode:)`` 偏好的檔案巨集
    ///
    /// 對應 swiftformat 的 `file-macro` option。Swift 6 起 `#file` 與 `#fileID` 行為相同。
    public enum FileMacro: String, FormatRuleOption {

        /// 對應的 swiftformat CLI option flag 名稱
        public static let flagName = "fileMacro"

        /// 偏好 `#file`（swiftformat 上游預設）
        case file = "#file"

        /// 偏好 `#fileID`——簡短的 `模組名/檔名.swift` 形式
        case fileID = "#fileID"
    }
}
