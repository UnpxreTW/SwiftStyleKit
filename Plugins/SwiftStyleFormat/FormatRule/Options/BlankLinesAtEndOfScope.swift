public extension FormatRule {

    /// `blankLinesAtEndOfScope` 規則對 type 宣告結尾空白行的處理方式
    ///
    /// 對應 swiftformat 的 `type-blank-lines` option。此 option 由
    /// `blankLinesAtEndOfScope` 擁有（列在它的 `options:`）；`blankLinesAroundMark`
    /// 等規則的 `sharedOptions` 也會讀它，但不重複暴露。
    enum TypeBlankLines: String {

        /// 移除 type 宣告結尾的空白行（swiftformat 上游預設）
        case remove

        /// 在 type 宣告的 `}` 前插入空白行
        case insert

        /// 保留 type 宣告結尾既有的空白行
        case preserve
    }
}
