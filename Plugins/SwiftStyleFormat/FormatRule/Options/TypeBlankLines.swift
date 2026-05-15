public extension FormatRule {

    /// type 宣告邊界（開頭與結尾）空白行的處理方式
    ///
    /// ``FormatRule/typeBlankLines(mode:)`` 全域 option 的值型別，對應 swiftformat
    /// 的 `type-blank-lines` option。此 option 不專屬單一規則——
    /// ``FormatRule/blankLinesAtEndOfScope(rule:)`` 等規則共讀它決定 type 宣告邊界
    /// 的空白行行為（見 swiftformat issue #1745）。
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
