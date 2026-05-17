public extension FormatRule {

    /// ``FormatRule/elseOnSameLine(rule:elsePosition:guardElse:)`` 的 `else` / `catch` 擺位
    ///
    /// 對應 swiftformat 的 `else-position` option。
    enum ElsePosition: String, FormatRuleOption {

        /// 對應的 swiftformat CLI option flag 名稱
        public static let flagName = "elsePosition"

        /// `else` / `catch` 接在前一個 `}` 同一行（`} else {`）
        case sameLine = "same-line"

        /// `else` / `catch` 換到下一行
        case nextLine = "next-line"
    }

    /// ``FormatRule/elseOnSameLine(rule:elsePosition:guardElse:)`` 對 `guard` 的 `else` 擺位
    ///
    /// 對應 swiftformat 的 `guard-else` option。
    enum GuardElsePosition: String, FormatRuleOption {

        /// 對應的 swiftformat CLI option flag 名稱
        public static let flagName = "guardElse"

        /// `else` 永遠接在 `guard` 條件後同一行
        case sameLine = "same-line"

        /// `guard` 條件跨多行時 `else` 換到下一行
        case nextLine = "next-line"

        /// 保留既有擺位、不強制
        case auto
    }
}
