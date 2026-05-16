public extension FormatRule {

    /// ``FormatRule/blankLinesAtEndOfScope(rule:mode:)`` 對 type 宣告邊界空白行的處理方式
    ///
    /// 對應 swiftformat 的 `type-blank-lines` option。此 option 在 swiftformat
    /// 跨規則共用（見 swiftformat issue #1745）；SwiftStyleKit 統一由
    /// ``FormatRule/blankLinesAtEndOfScope(rule:mode:)`` 的 `mode:` 暴露、其他
    /// 規則不重複帶。
    enum TypeBlankLines: String, FormatRuleOption {

        /// 對應的 swiftformat CLI option flag 名稱
        public static let flagName = "typeBlankLines"

        /// 移除 type 宣告邊界的空白行（swiftformat 上游預設）
        case remove

        /// 在 type 宣告邊界插入空白行
        case insert

        /// 保留 type 宣告邊界既有的空白行
        case preserve
    }
}
