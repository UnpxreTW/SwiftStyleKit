//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

extension FormatRule {
	/// 此 package 啟用的規則集合
	public static var allRules: [Self] = [
		.acronyms(.on),
		.andOperator(.on),
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
		.blankLineAfterSwitchCase(.off),
		// 不啟用：Opt-in 規則、依SwiftStyleKit 預設策略對 Opt-in 規則 傾向 .disable。
		// case 留在 enum 內形成「考慮過且選擇關閉」的 in-tree 宣告、fork 可改
		.blankLinesAfterGuardStatements(rule: .disable),
		.blankLinesAroundMark(rule: .enable),
		.blankLinesAtEndOfScope(rule: .enable),
		.blankLinesAtStartOfScope(rule: .enable),
		.blankLinesBetweenChainedFunctions(rule: .enable),
		.blankLinesBetweenImports(rule: .enable),
		.blankLinesBetweenScopes(rule: .enable),
		.blockComments(rule: .enable),
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
		.fileMacro(rule: .enable),
		.genericExtensions(rule: .enable),
		.headerFileName(rule: .enable),
		.hoistAwait(rule: .enable),
		.hoistPatternLet(rule: .enable),
		.hoistTry(rule: .enable),
		// indent: .tab——縮排的視覺寬度交給讀者決定，對視力需求不同的
		// 人友善。tab 在語意上就是「一層縮排」，實際顯示幾欄寬由每位
		// 開發者在自己的編輯器設定；需要較寬縮排才能看清層級的人可自行
		// 調整，不必改動檔案、也不影響他人
		.indent(rule: .enable),
		.initCoderUnavailable(rule: .enable),
		// 不啟用：Opt-in 規則、且有 footgun——規則只看 .count token 不知 type 是否
		// 實作 isEmpty，對自訂 type 暴露 .count 但無 .isEmpty 改寫後編譯 fail
		.isEmpty(rule: .disable),
		.leadingDelimiters(rule: .enable),
		.linebreakAtEndOfFile(rule: .enable),
		.linebreaks(rule: .enable),
		.markTypes(rule: .enable),
		.modifierOrder(rule: .enable),
		.modifiersOnSameLine(rule: .enable),
		// 不啟用：Opt-in 規則、且 borrowing/consuming 是 explicit performance 意圖文件、
		// 同 redundantInternal/redundantPublic/redundantViewBuilder 同調（顯式性 > 簡潔）
		.noExplicitOwnership(rule: .disable),
		.noForceTryInTests(rule: .enable),
		.noForceUnwrapInTests(rule: .enable),
		.noGuardInTests(rule: .enable),
		.numberFormatting(rule: .enable),
		.organizeDeclarations(rule: .enable),
		.opaqueGenericParameters(rule: .enable),
		.preferCountWhere(rule: .enable),
		// 不啟用：Opt-in 規則、且跟 Swift 社群慣例反向——Apple Swift Style Guide 偏
		// `!flag` 簡潔形式；`== false` 是 PHP/C 傳統風格、Swift 罕用
		.preferExplicitFalse(rule: .disable),
		.preferFinalClasses(rule: .enable),
		.preferForLoop(rule: .enable),
		.preferKeyPath(rule: .enable),
		.preferSwiftStringAPI(rule: .enable),
		.preferSwiftTesting(rule: .enable),
		.privateStateVariables(rule: .enable),
		.propertyTypes(rule: .enable),
		.redundantAsync(rule: .enable),
		.redundantBackticks(rule: .enable),
		.redundantBreak(rule: .enable),
		// 不啟用：保留 `{ ... }()` 立即呼叫 closure 作為宣告斷行手段——
		// 當初始化呼叫很長時，包進 closure 讓 body 多行斷開比單行宣告美觀；
		// 規則啟用會把這種寫法收回單行
		.redundantClosure(rule: .disable),
		.redundantEmptyView(rule: .enable),
		.redundantEquatable(rule: .enable),
		.redundantExtensionACL(rule: .enable),
		.redundantFileprivate(rule: .enable),
		.redundantGet(rule: .enable),
		.redundantInit(rule: .enable),
		// 不啟用：訪問控制的顯式性是團隊風格偏好——`internal` 顯式寫出來
		// 可作為 API 邊界文件、保留 SwiftStyleKit 下游選擇空間，case 在 enum
		// 內形成「考慮過且選擇關閉」的 in-tree 宣告
		.redundantInternal(rule: .disable),
		.redundantLet(rule: .enable),
		.redundantLetError(rule: .enable),
		.redundantMemberwiseInit(rule: .enable),
		.redundantNilInit(rule: .enable),
		.redundantObjc(rule: .enable),
		.redundantOptionalBinding(rule: .enable),
		.redundantParens(rule: .enable),
		.redundantPattern(rule: .enable),
		// 不啟用：訪問控制的顯式性是團隊風格偏好——即使被 internal type 包住、
		// 明確標 `public` 仍可作為「未來可能上升為 API 邊界」的文件；同
		// `redundantInternal` 同調（顯式性 > 簡潔）、保留 fork 選擇空間
		.redundantPublic(rule: .disable),
		.redundantRawValues(rule: .enable),
		.redundantReturn(rule: .enable),
		.redundantSelf(rule: .enable),
		.redundantSendable(rule: .enable),
		.redundantStaticSelf(rule: .enable),
		.redundantSwiftTestingSuite(rule: .enable),
		.redundantThrows(rule: .enable),
		.redundantType(rule: .enable),
		.redundantTypedThrows(rule: .enable),
		.redundantVariable(rule: .enable),
		// 不啟用：SwiftUI `@ViewBuilder` 標註顯式性是團隊風格偏好——即使 body 自動帶
		// ViewBuilder、helper computed property 內部已用 VStack 包住、明確標
		// `@ViewBuilder` 仍可作為「這是 view-building scope」的文件提示；同
		// `redundantInternal` / `redundantPublic` 同調（顯式性 > 簡潔）、保留 fork 選擇空間
		.redundantViewBuilder(rule: .disable),
		.redundantVoidReturnType(rule: .enable),
		.semicolons(rule: .enable),
		.simplifyGenericConstraints(rule: .enable),
		.singlePropertyPerLine(rule: .enable),
		.sortDeclarations(rule: .enable),
		.sortImports(rule: .enable),
		// 不啟用：規則對「所有」switch case 字母排序、不是 marker-based、會洗掉
		// 「按 priority / state machine / by domain」排序的業務語意；與 blankLineAfterSwitchCase
		// 同 .disable 形成「switch case 順序由業務語意決定、不由規則改寫」的一致立場
		.sortSwitchCases(rule: .disable),
		.sortTypealiases(rule: .enable),
		.spaceAroundBraces(rule: .enable),
		.spaceAroundBrackets(rule: .enable),
		.spaceAroundComments(rule: .enable),
		.spaceAroundGenerics(rule: .enable),
		.spaceAroundOperators(rule: .enable),
		.spaceAroundParens(rule: .enable),
		.spaceInsideBraces(rule: .enable),
		.spaceInsideBrackets(rule: .enable),
		.spaceInsideComments(rule: .enable),
		.spaceInsideGenerics(rule: .enable),
		.spaceInsideParens(rule: .enable),
		.strongOutlets(rule: .enable),
		.strongifiedSelf(rule: .enable),
		.swiftTestingTestCaseNames(rule: .enable),
		.testSuiteAccessControl(rule: .enable),
		.todos(rule: .enable),
		.trailingClosures(rule: .enable),
		.trailingCommas(rule: .enable),
		.trailingSpace(rule: .enable),
		.typeSugar(rule: .enable),
		.unusedArguments(rule: .enable),
		// 不啟用：規則只看 static reference、對 @objc selector / KVC value(forKey:) /
		// Mirror reflection 等 dynamic dispatch 無感、可能誤刪；fork 用戶若有
		// reflection-heavy 寫法應自訂 preserveDecls 名單後再啟用
		.unusedPrivateDeclarations(rule: .disable),
		// 不啟用：規則純文字操作、自動補 `import <module>` 但不檢查 module 是否可解析；
		// fork 設 `urlMacro: "#URL,URLFoundation"` 卻沒裝對應 dependency 時、自動補的
		// import 會編譯 fail。case 留在 enum 內形成「考慮過且選擇關閉」的 in-tree 宣告、
		// fork 自備 macro dependency 後可改 .enable + 設 urlMacro option
		.urlMacro(rule: .disable),
		.validateTestCases(rule: .enable),
		.void(rule: .enable),
		.wrap(rule: .enable),
		.wrapArguments(rule: .enable),
		.wrapAttributes(rule: .enable),
		// 不啟用：inline `case .foo: return bar` 對短 body 一行緊湊、可讀性更高；
		// 強制換行讓「狀態 → 單行 handler」型 switch 變冗長；與 blankLineAfterSwitchCase
		// / sortSwitchCases 已 .disable 同精神（switch case 結構由業務決定、不機械改寫）
		.wrapCaseBodies(rule: .disable),
		// 不啟用：`guard let x = y else { return }` / `if foo { return }` 是 Swift 常見
		// early-return idiom、單行緊湊；強制換行讓 guard / 簡短 if 變多行、邊際好處不大；
		// 與 wrapCaseBodies .disable 同類精神（單行 conditional body 緊湊）
		.wrapConditionalBodies(rule: .disable),
		.wrapEnumCases(rule: .enable),
		.wrapFunctionBodies(rule: .enable),
		.wrapLoopBodies(rule: .enable),
		// 不啟用：Opt-in 規則、SwiftStyleKit 預設策略對 Opt-in 規則傾向 .disable；
		// case 留在 enum 內形成「考慮過且選擇關閉」的 in-tree 宣告、fork 可改
		.wrapMultilineConditionalAssignment(rule: .disable),
		.wrapMultilineFunctionChains(rule: .enable),
		// 啟用：多行 if/guard/while 條件時 swiftformat 把 `{` 推到獨立行，與 swiftlint
		// opening_brace（`{` 同行、--strict）方向相反觸發 CI 報錯；我們刻意把這衝突當作
		// 「判斷式超過 maxWidth（120）該壓短」的信號、而非缺陷。func/init 因 closingParen:
		// .balanced 不觸發；guard/switch/do-catch 在 opening_brace 無豁免、信號最硬
		.wrapMultilineStatementBraces(rule: .enable),
		// 不啟用：single-line computed property（`var id: Int { rawValue }`、SwiftUI
		// `var body: some View { ... }`）是 Swift 5.9+ 推薦慣例、社群主流寫法；
		// 規則強制拆多行會把簡潔 view modifier 弄冗長、跟 implicit return 趨勢反向；
		// case 留在 enum 內形成「考慮過且選擇關閉」的 in-tree 宣告
		.wrapPropertyBodies(rule: .disable),
		.wrapSingleLineComments(rule: .enable),
		// 不啟用：`case .a, .b:` 短 pattern 列同行屬 Swift idiomatic；強制換行 + align
		// 讓「2-3 個 enum case 共用 handler」型 switch 變 cluttered；與 sortSwitchCases /
		// blankLineAfterSwitchCase / wrapCaseBodies 同 .disable 同精神（switch 結構由業務決定）
		.wrapSwitchCases(rule: .disable),
		.yodaConditions(rule: .enable),
		// 全域 option（無啟用開關、mode 預設 .preserve）
		.typeBlankLines(),
		.wrapStringInterpolation()
	]

	/// 全部啟用規則展開成 swiftformat CLI 參數
	public static var allToCommand: [String] { allRules.flatMap(\.cliArguments) }
}
