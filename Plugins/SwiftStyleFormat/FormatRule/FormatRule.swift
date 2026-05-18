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

    /// 移除 import 陳述式之間的空白行
    case blankLinesBetweenImports(rule: Flag)

    /// 在型別與函式宣告之間插入空白行
    case blankLinesBetweenScopes(rule: Flag)

    /// 依選定風格擺放大括號
    ///
    /// `allman` 為 `.enable` 時開大括號換行（Allman）、`.disable` 時同行（K&R）。
    case braces(rule: Flag, allman: Toggle = .disable)

    /// 用 `if` / `switch` 運算式做條件賦值
    ///
    /// `mode` 為 `.afterProperty` 只改寫新屬性宣告後的賦值、`.always` 連既有
    /// lvalue 的賦值也改。Swift 5.9+ 才有此語法、低於 5.9 規則自動 no-op。
    case conditionalAssignment(rule: Flag, mode: ConditionalAssignmentMode = .always)

    /// 連續多個空白行收成一個
    case consecutiveBlankLines(rule: Flag)

    /// 連續多個空格收成一個
    case consecutiveSpaces(rule: Flag)

    /// 讓 `switch` 內各 case 的間距一致
    case consistentSwitchCaseSpacing(rule: Flag)

    /// API 宣告用 doc comment（`///`）、其他用一般註解（`//`）
    ///
    /// `mode` 為 `.beforeDeclarations` 雙向正規化、`.preserve` 只升級不降級。
    case docComments(rule: Flag, mode: DocCommentsMode = .beforeDeclarations)

    /// doc comment 移到宣告的修飾詞 / attribute 之前
    case docCommentsBeforeModifiers(rule: Flag)

    /// 移除重複的 import 陳述式
    case duplicateImports(rule: Flag)

    /// `else` / `catch` / `repeat`-`while` 關鍵字依風格擺位
    ///
    /// `elsePosition` 管 `else` / `catch`、`guardElse` 管 `guard` 的 `else`。
    case elseOnSameLine(rule: Flag, elsePosition: ElsePosition = .sameLine, guardElse: GuardElsePosition = .nextLine)

    /// 移除空大括號內的空白
    case emptyBraces(rule: Flag, mode: EmptyBracesSpacing = .noSpace)

    /// 移除空的、不宣告 protocol 一致性的 extension
    case emptyExtensions(rule: Flag)

    /// 只裝靜態成員的型別轉成 `enum` 命名空間
    ///
    /// `mode` 為 `.always` 連 `final class` 也轉、`.structsOnly` 只轉 `struct`。
    case enumNamespaces(rule: Flag, mode: EnumNamespacesMode = .always)

    /// 把 SwiftUI `EnvironmentValues` 定義改寫成使用 `@Entry` macro
    ///
    /// `@Entry` macro 需 Swift 6.0+（Xcode 16）、低於 6.0 規則自動 no-op。
    case environmentEntry(rule: Flag)

    /// 設定 extension 的存取控制修飾詞擺位
    ///
    /// `mode` 為 `.onExtension` 放在 `extension` 上、`.onDeclarations` 下放到成員。
    case extensionAccessControl(rule: Flag, mode: ExtensionACLPlacement = .onDeclarations)

    /// 套用統一的檔案標頭
    ///
    /// `header` 為標頭內容（`strip` / `ignore` / 模板文字），`dateFormat`、`timeZone`
    /// 供模板日期 token 使用。此規則不在 `allRules`——標頭內容隨專案而異、由 plugin 執行期組裝。
    case fileHeader(rule: Flag, header: String, dateFormat: String, timeZone: String)

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

extension FormatRule {
    /// 此 package 啟用的規則集合
    public static var allRules: [Self] = [
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
        .blankLinesAtEndOfScope(rule: .enable),
        .blankLinesAtStartOfScope(rule: .enable),
        .blankLinesBetweenChainedFunctions(rule: .enable),
        .blankLinesBetweenImports(rule: .enable),
        .blankLinesBetweenScopes(rule: .enable),
        .braces(rule: .enable),
        .conditionalAssignment(rule: .enable),
        .consecutiveBlankLines(rule: .enable),
        .consecutiveSpaces(rule: .enable),
        .consistentSwitchCaseSpacing(rule: .enable),
        .docComments(rule: .enable),
        .docCommentsBeforeModifiers(rule: .enable),
        .duplicateImports(rule: .enable),
        .elseOnSameLine(rule: .enable),
        .emptyBraces(rule: .enable),
        .emptyExtensions(rule: .enable),
        .enumNamespaces(rule: .enable),
        .environmentEntry(rule: .enable),
        .extensionAccessControl(rule: .enable),
        // 全域 option（無啟用開關、mode 預設 .preserve）
        .typeBlankLines()
    ]

    /// 全部啟用規則展開成 swiftformat CLI 參數
    public static var allToCommand: [String] { allRules.flatMap { $0.cliArguments } }
}
