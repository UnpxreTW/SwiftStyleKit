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
    ///
    /// type 宣告結尾的空白行行為由全域 option ``typeBlankLines(mode:)`` 控制。
    case blankLinesAtEndOfScope(rule: Flag)

    /// 移除 scope 起始的空白行
    ///
    /// type 宣告開頭的空白行行為由全域 option ``typeBlankLines(mode:)`` 控制。
    case blankLinesAtStartOfScope(rule: Flag)

    /// 移除鏈式呼叫之間的空白行（保留換行）
    case blankLinesBetweenChainedFunctions(rule: Flag)

    // MARK: - 全域 option

    /// type 宣告邊界（開頭與結尾）的空白行政策
    ///
    /// 對應 swiftformat 全域 option `type-blank-lines`——``blankLinesAtStartOfScope(rule:)``
    /// 與 ``blankLinesAtEndOfScope(rule:)`` 共讀它（見 swiftformat issue #1745）。無
    /// ``Flag``：option 不是規則、swiftformat 沒有 `--enable` / `--disable` 之分。
    /// `mode` 預設 `.preserve`（SwiftStyleKit 選用值）、展開成 `--typeBlankLines preserve`；
    /// 設為 `nil` 則不展開、由 swiftformat 取上游預設。
    case typeBlankLines(mode: TypeBlankLines? = .preserve)
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
        // 不啟用：對齊主人 96.7% 既有 switch case 緊鄰寫法（三 repo 86 switch、
        // 648 case 無空行、僅 22 case 有空行）；保留 case 在 enum 內形成「考慮
        // 過且選擇關閉」的 in-tree 宣告，未來偏好改變只改 allRules 不需重新討論
        .blankLineAfterSwitchCase(rule: .disable),
        .blankLinesAroundMark(rule: .enable),
        .blankLinesAtEndOfScope(rule: .enable),
        .blankLinesAtStartOfScope(rule: .enable),
        .blankLinesBetweenChainedFunctions(rule: .enable),
        // 全域 option（無啟用開關、mode 預設 .preserve）
        .typeBlankLines()
    ]

    /// 全部啟用規則展開成 swiftformat CLI 參數
    static var allToCommand: [String] { allRules.flatMap { $0.cliArguments } }
}
