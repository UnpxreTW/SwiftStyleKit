/// 格式規則
///
/// 每個 case 對應 swiftformat 一條 rule，Mirror reflection 自動展開為 CLI 參數。
public enum FormatRule {

    /// 當設定的單字字首為大寫時轉換成全大寫，清單見 ``defaultAcronyms``
    case acronyms(rule: Flag, String = FormatRule.defaultAcronyms)

    /// 偏好在 `if`、`guard`、`while` 條件式中使用逗號取代 `&&`
    case andOperator(rule: Flag)

    /// 偏好在 protocol 宣告中使用 `AnyObject` 取代 `class`
    case anyObjectProtocol(rule: Flag)

    /// 偏好使用 `@main` 取代 `@UIApplicationMain` 與 `@NSApplicationMain`
    case applicationMain(rule: Flag)

    /// 偏好 `assertionFailure` 與 `preconditionFailure` 取代判斷為 `false` 的測試
    case assertionFailures(rule: Flag)

    /// 在 `import` 區塊後插入空白行
    case blankLineAfterImports(rule: Flag)

    /// 在 `switch` 內每個 `case` 後插入空白行
    case blankLineAfterSwitchCase(rule: Flag, mode: BlankLineAfterSwitchCaseMode? = nil)

    /// 在 `MARK:` 註解前後插入空白行
    case blankLinesAroundMark(rule: Flag, lineAfterMarks: Toggle = .enable)

    /// 移除 scope 結尾的空白行
    case blankLinesAtEndOfScope(rule: Flag, mode: TypeBlankLines = .remove)
}

public extension FormatRule {
    /// 此 package 啟用的規則集合
    static var allRules: [Self] = [
        .acronyms(rule: .enable),
        .andOperator(rule: .enable),
        .anyObjectProtocol(rule: .enable),
        .applicationMain(rule: .enable),
        // 不啟用：保留 `assert(false, ...)` / `precondition(false, ...)` 三段式句型作為
        // 「為什麼這條路徑不該被走到」的註解體；維持 `assert(condition)` 與 `assert(false)`
        // 同 entry point 的 API 心智模型統一
        .assertionFailures(rule: .disable),
        .blankLineAfterImports(rule: .enable),
        // 不啟用：對齊switch case 緊鄰寫法在 Swift 社群屬主流、規則啟用會插入空行
        // 改變 case 區塊密度；保留 case 在 enum 內形成「考慮
        // 過且選擇關閉」的 in-tree 宣告，未來偏好改變只改 allRules 不需重新討論
        .blankLineAfterSwitchCase(rule: .disable),
        .blankLinesAroundMark(rule: .enable),
        .blankLinesAtEndOfScope(rule: .enable)
    ]

    /// 全部啟用規則展開成 swiftformat CLI 參數
    static var allToCommand: [String] { allRules.flatMap { $0.cliArguments } }
}
