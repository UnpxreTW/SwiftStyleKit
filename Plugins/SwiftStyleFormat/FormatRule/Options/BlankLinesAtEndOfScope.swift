public extension FormatRule {

    /// `blankLinesAtEndOfScope` 與 `blankLinesAtStartOfScope` 規則對 type 宣告
    /// 邊界空白行的處理方式
    ///
    /// 對應 swiftformat 的 `type-blank-lines` option。此 option 同時列在
    /// `blankLinesAtEndOfScope` 與 `blankLinesAtStartOfScope` 的 `options:`、
    /// 兩條 case 都暴露它；`blankLinesAroundMark` 等規則的 `sharedOptions` 也會
    /// 讀它，但不重複暴露。
    enum TypeBlankLines: String, FormatRuleOption {

        /// 對應的 swiftformat CLI option flag 名稱
        public static let flagName = "typeBlankLines"

        /// 移除 type 宣告結尾的空白行（swiftformat 上游預設）
        case remove

        /// 在 type 宣告的 `}` 前插入空白行
        case insert

        /// 保留 type 宣告結尾既有的空白行
        case preserve
    }
}
