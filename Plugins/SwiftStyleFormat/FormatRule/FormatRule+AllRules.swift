//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

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
		// 不啟用：對齊主人 96.7% 既有 switch case 緊鄰寫法（三 repo 86 switch、
		// 648 case 無空行、僅 22 case 有空行）；保留 case 在 enum 內形成「考慮
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
		.leadingDelimiters(rule: .enable),
		.linebreakAtEndOfFile(rule: .enable),
		.linebreaks(rule: .enable),
		.markTypes(rule: .enable),
		.modifierOrder(rule: .enable),
		.modifiersOnSameLine(rule: .enable),
		.noForceTryInTests(rule: .enable),
		.noForceUnwrapInTests(rule: .enable),
		.numberFormatting(rule: .enable),
		.opaqueGenericParameters(rule: .enable),
		.preferCountWhere(rule: .enable),
		.preferForLoop(rule: .enable),
		.preferKeyPath(rule: .enable),
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
		.redundantNilInit(rule: .enable),
		.redundantObjc(rule: .enable),
		.redundantOptionalBinding(rule: .enable),
		.redundantParens(rule: .enable),
		.redundantPattern(rule: .enable),
		.redundantRawValues(rule: .enable),
		.redundantReturn(rule: .enable),
		.redundantSelf(rule: .enable),
		.redundantStaticSelf(rule: .enable),
		.redundantType(rule: .enable),
		.redundantTypedThrows(rule: .enable),
		.redundantVoidReturnType(rule: .enable),
		.semicolons(rule: .enable),
		.sortDeclarations(rule: .enable),
		.sortImports(rule: .enable),
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
		.todos(rule: .enable),
		.trailingClosures(rule: .enable),
		.trailingCommas(rule: .enable),
		.trailingSpace(rule: .enable),
		.typeSugar(rule: .enable),
		.unusedArguments(rule: .enable),
		.void(rule: .enable),
		.wrap(rule: .enable),
		.wrapArguments(rule: .enable),
		.wrapAttributes(rule: .enable),
		.wrapFunctionBodies(rule: .enable),
		// 全域 option（無啟用開關、mode 預設 .preserve）
		.typeBlankLines(),
		.wrapStringInterpolation()
	]

	/// 全部啟用規則展開成 swiftformat CLI 參數
	public static var allToCommand: [String] { allRules.flatMap(\.cliArguments) }
}
