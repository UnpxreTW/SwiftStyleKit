//
//  FormatRuleCodegen
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

// swiftformat:disable indent
// swiftlint:disable file_length
// indent：renderOverloads 的多行 string 模板帶 load-bearing 的 `\t` 縮排（直接寫進生成檔），
// swiftformat 的 indent 重排會破壞輸出——故只停 indent、模板縮排手動維持，其餘格式規則照常套用。
// file_length：逐條規則 + 模板 + 報告屬正常規模、無品質意義。

import Foundation
import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder

// MARK: - 流程概述
//
// 漸進遷移：FormatRule 過渡期維持 enum + 載體 case `_storage(Storage)`，規則逐條搬進巢狀
// `enum Storage`；**Storage 成員身分即「已遷移」標記**（不需另設帳本）。codegen：
//   1) 讀 FormatRule.swift、找巢狀 `enum Storage`，為每個 Storage case 補缺 default（讓 .off 可省 option），
//   2) 生成型別安全 .on/.off/diagnostic 工廠（FormatRule+SafeOverloads.swift）。
//
// 工廠 body 形隨 FormatRule 宣告而變：
//   - enum（過渡期）→ `._storage(.X(...))`（包進載體 case）
//   - struct（最終 flip 後）→ `.init(.X(...))`
// 偵測來源含 `struct FormatRule` 即視為已 flip。
//
// Storage 為空（如地基 PR）→ 不寫生成檔（避免空 extension 被 emptyExtensions 規則處理）。

// MARK: - 模型

/// 單一 case 的一個參數：rule 旗標本身、或某條 option。
struct Param {

	/// 參數 label（rule, mode, allman, ...）；unnamed associated value 為空字串
	let label: String

	/// 型別文字（Flag, Toggle, [String]?, Int?, String ...）
	let typeText: String

	/// 預設值文字（原樣保留、含 multi-line array literal）；無預設為 nil
	let defaultText: String?

	/// 是否為規則旗標本身（rule: Flag）
	var isRule: Bool {
		typeText == "Flag" && label == "rule"
	}
}

/// 從 Storage enum 解析出的單一 case。
struct CaseInfo {

	/// 規則 case 名（＝ public API 工廠名、＝ swiftformat rule 名）
	let name: String

	/// case 的所有參數（含 rule 旗標與 extra option）
	let params: [Param]

	/// 是否含 rule 旗標（globalOption case 無）
	var hasRule: Bool {
		params.contains { $0.isRule }
	}

	/// 除 rule 旗標外的 option 參數
	var extraParams: [Param] {
		params.filter { !$0.isRule }
	}
}

// MARK: - 找到 enum Storage、走訪 case

/// 走訪語法樹、把巢狀 `enum Storage` 的每個 case 解析成 CaseInfo（＝已遷移規則）。
final class CaseCollector: SyntaxVisitor {

	/// 收集到的所有 Storage case
	var cases: [CaseInfo] = []

	/// 是否正在 `enum Storage` 內（只收集其 case；FormatRule 直接 case ＝未遷移、不收）。
	private var inStorage = false

	// 一律下探（巢狀 Storage 是 FormatRule 的 child、不能 skip FormatRule）；進 Storage 才開收集旗標。
	override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
		if node.name.text == "Storage" { inStorage = true }
		return .visitChildren
	}

	override func visitPost(_ node: EnumDeclSyntax) {
		if node.name.text == "Storage" { inStorage = false }
	}

	override func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
		guard inStorage else { return .skipChildren }
		for element in node.elements {
			let name = element.name.text
			var params: [Param] = []
			if let paramClause = element.parameterClause {
				for param in paramClause.parameters {
					let label = param.firstName?.text ?? ""
					let typeText = param.type.trimmedDescription
					let defaultText = param.defaultValue?.value.trimmedDescription
					params.append(Param(
						label: label == "_" ? "" : label,
						typeText: typeText,
						defaultText: defaultText
					))
				}
			}
			cases.append(CaseInfo(name: name, params: params))
		}
		return .skipChildren
	}
}

// MARK: - 合成預設（讓 .off overload 可省略全部 option）

/// 為「無原始預設值的 extra param」合成一個預設。
func synthesizedDefault(forType typeText: String) -> String? {
	if typeText.hasSuffix("?") { return "nil" }
	switch typeText {
	case "String": return "\"\""
	case "Int": return "0"
	case "[String]": return "[]"
	default: return nil
	}
}

/// 一筆「被合成預設」的紀錄。
struct SynthRecord {

	/// 被補預設的 case 名
	let caseName: String

	/// 被補預設的參數 label
	let label: String

	/// 該參數型別文字
	let type: String

	/// 合成注入的預設值文字
	let injected: String
}

/// 一筆「無法安全合成預設」的紀錄（gate）。
struct SynthFailure {

	/// 出問題的 case 名
	let caseName: String

	/// 缺 default 又無法合成的參數 label
	let label: String

	/// 該參數型別文字
	let type: String
}

/// 用 SyntaxRewriter 對 `enum Storage` 的 case 補缺 default、保留所有 doc comment / trivia。
final class StorageRewriter: SyntaxRewriter {

	/// 改寫過程中合成預設的紀錄
	var synthesized: [SynthRecord] = []

	/// 無法安全合成預設的 param 紀錄（gate）
	var synthesisFailures: [SynthFailure] = []

	/// 是否正在 `enum Storage` 內（只改寫其 case）。
	private var inStorage = false

	// 一律下探以抵達巢狀 Storage；進 Storage 才開改寫旗標、避免動到 FormatRule 直接 case。
	override func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
		guard node.name.text == "Storage" else { return super.visit(node) }
		inStorage = true
		let result = super.visit(node)
		inStorage = false
		return result
	}

	override func visit(_ node: EnumCaseElementSyntax) -> EnumCaseElementSyntax {
		guard inStorage else { return node }
		var node = node
		let caseName = node.name.text
		guard var paramClause = node.parameterClause else { return node }
		var newParams = paramClause.parameters
		for index in newParams.indices {
			let param = newParams[index]
			let label = param.firstName?.text ?? ""
			let typeText = param.type.trimmedDescription
			let isRule = (typeText == "Flag" && label == "rule")
			guard !isRule, param.defaultValue == nil else { continue }
			guard let synth = synthesizedDefault(forType: typeText) else {
				synthesisFailures.append(SynthFailure(caseName: caseName, label: label, type: typeText))
				continue
			}
			let synthExpr = ExprSyntax("\(raw: synth)")
			newParams[index] = param.with(
				\.defaultValue,
				InitializerClauseSyntax(
					equal: .equalToken(leadingTrivia: .space, trailingTrivia: .space),
					value: synthExpr
				)
			)
			synthesized.append(SynthRecord(caseName: caseName, label: label, type: typeText, injected: synth))
		}
		paramClause.parameters = newParams
		node.parameterClause = paramClause
		return node
	}
}

// MARK: - 簽名與 body 片段

/// 工廠的 option 參數列（保留 default；unnamed 給內部名 value）
func renderOptionParams(_ caseInfo: CaseInfo) -> [String] {
	caseInfo.extraParams.map { param in
		let label = param.label.isEmpty ? "_ value" : param.label
		let def = param.defaultText.map { " = \($0)" } ?? ""
		return "\(label): \(param.typeText)\(def)"
	}
}

/// Storage case 建構引數列（enable：帶 extra 值；disable：只有 rule）
func renderStorageArgs(_ caseInfo: CaseInfo, ruleArg: String, withOptions: Bool) -> String {
	var args: [String] = ["rule: \(ruleArg)"]
	if withOptions {
		for param in caseInfo.extraParams {
			args.append(param.label.isEmpty ? "value" : "\(param.label): \(param.label)")
		}
	}
	return args.joined(separator: ", ")
}

/// 把 Storage case 建構包成一個 FormatRule 值——過渡期 enum 用載體、flip 後 struct 用 init。
/// codegen 單執行緒、無並行存取 → nonisolated(unsafe)。
nonisolated(unsafe) var wrapPrefix = "._storage"
func wrapBody(_ caseName: String, _ args: String) -> String {
	wrapPrefix == ".init" ? ".init(.\(caseName)(\(args)))" : "._storage(.\(caseName)(\(args)))"
}

/// 為單一 Storage case 生成 .on / .off (+ diagnostic) 工廠。globalOption（無 rule）→ 單一 passthrough。
func renderOverloads(_ caseInfo: CaseInfo) -> String {
	guard caseInfo.hasRule else {
		// 全域 option：無 rule、單一 passthrough（mode 預設保留）
		let signature = renderOptionParams(caseInfo).joined(separator: ", ")
		let args = caseInfo.extraParams.map { param in
			param.label.isEmpty ? "value" : "\(param.label): \(param.label)"
		}.joined(separator: ", ")
		return """
		\t/// 全域 option（無 rule Flag）：直接 passthrough，無 on/off 之分
		\tpublic static func \(caseInfo.name)(\(signature)) -> FormatRule {
		\t\t\(wrapBody(caseInfo.name, args))
		\t}
		"""
	}
	let onSignature = (["_ state: OnToken"] + renderOptionParams(caseInfo)).joined(separator: ", ")
	let onOverload = """
	\t/// 啟用 + 帶 option（option 預設＝原 SSK 簽名預設）
	\tpublic static func \(caseInfo.name)(\(onSignature)) -> FormatRule {
	\t\t\(wrapBody(caseInfo.name, renderStorageArgs(caseInfo, ruleArg: ".enable", withOptions: true)))
	\t}
	"""
	let offOverload = """
	\t/// 停用（不可帶 option）
	\tpublic static func \(caseInfo.name)(_ state: OffToken) -> FormatRule {
	\t\t\(wrapBody(caseInfo.name, renderStorageArgs(caseInfo, ruleArg: ".disable", withOptions: false)))
	\t}
	"""
	guard !caseInfo.extraParams.isEmpty else {
		return [onOverload, offOverload].joined(separator: "\n\n")
	}
	let diagnosticParams = (["_ state: OffToken"] + renderOptionParams(caseInfo)).joined(separator: ", ")
	let diagnosticOverload = """
	\t/// `.off` 誤帶 option 的編譯期診斷（命中即報錯、不會被呼叫）
	\t@available(*, unavailable, message: ".off 不可帶 option（option 只在 .on 有效）")
	\tpublic static func \(caseInfo.name)(\(diagnosticParams)) -> FormatRule {
	\t\tfatalError("unavailable")
	\t}
	"""
	return [onOverload, offOverload, diagnosticOverload].joined(separator: "\n\n")
}

// MARK: - 生成檔檔頭 + 報告 helper

let fileHeaderComment = """
//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

//  GENERATED by Tools/FormatRuleCodegen — DO NOT EDIT BY HAND.
//  已遷規則的型別安全 .on/.off 工廠。改 Storage case 簽名 / 搬規則進 Storage 後重跑 codegen。

// swiftformat:disable all
// 原因：本檔為 codegen 機械產出、簽名逐一對應 Storage 的原始 case。格式規則對生成檔可讀性無指引意義。
"""

/// 寫一行到 stderr。
func err(_ string: String) {
	FileHandle.standardError.write(Data((string + "\n").utf8))
}

// MARK: - 主流程

let arguments = CommandLine.arguments
guard arguments.count >= 3 else {
	FileHandle.standardError.write(Data("usage: FormatRuleCodegen <FormatRule.swift path> <output dir>\n".utf8))
	exit(2)
}
let formatRulePath = arguments[1]
let outDir = arguments[2]
let outPath = "\(outDir)/FormatRule+SafeOverloads.swift"

guard let source = try? String(contentsOfFile: formatRulePath, encoding: .utf8) else {
	FileHandle.standardError.write(Data("cannot read \(formatRulePath)\n".utf8))
	exit(1)
}
// 偵測 FormatRule 是否已 flip 成 struct → 決定工廠 body 形（載體 vs init）
wrapPrefix = source.contains("struct FormatRule") ? ".init" : "._storage"

let tree = Parser.parse(source: source)

// Storage 就地改寫（補缺 default）、寫回原檔
let storageRewriter = StorageRewriter()
let rewrittenTree = storageRewriter.visit(tree)
if !storageRewriter.synthesisFailures.isEmpty {
	err("ERROR: 以下 param 無原始 default 且型別無法安全合成預設（gate）：")
	for failure in storageRewriter.synthesisFailures {
		err("  \(failure.caseName).\(failure.label): \(failure.type)")
	}
	err("請在 synthesizedDefault(forType:) 補上該型別、或在 Storage case 給該 param 預設值。")
	exit(1)
}
try rewrittenTree.description.write(toFile: formatRulePath, atomically: true, encoding: .utf8)

let collector = CaseCollector(viewMode: .sourceAccurate)
collector.walk(rewrittenTree)
let allCases = collector.cases

// Storage 為空 → 移除生成檔（避免空 extension）；否則生成工廠
if allCases.isEmpty {
	try? FileManager.default.removeItem(atPath: outPath)
	err("===== CODEGEN REPORT =====")
	err("Storage 無 case（尚無已遷規則）→ 移除 \(outPath)")
	err("wrap mode: \(wrapPrefix)")
	err("==========================")
} else {
	// 先組 body，再依實際內容決定放哪些 swiftlint disable——生成檔逐條長大，小檔時
	// file_length / line_length / vertical_parameter_alignment 都不觸發，硬放會被
	// superfluous_disable_command 判多餘；故只在真會觸發時放、且非豁免規則配 enable。
	var body = "extension FormatRule {\n\n"
	for caseInfo in allCases {
		body += "\t// MARK: \(caseInfo.name)\n\n"
		body += renderOverloads(caseInfo) + "\n\n"
	}
	if body.hasSuffix("\n\n") {
		body.removeLast()
	}
	body += "}\n"

	let bodyLines = body.split(separator: "\n", omittingEmptySubsequences: false)
	let needLineLength = bodyLines.contains { $0.count > 120 }
	// 多行參數（某 param 的 default 是 multi-line array）→ vertical_parameter_alignment
	let needVertical = allCases.contains { caseInfo in
		caseInfo.params.contains { ($0.defaultText ?? "").contains("\n") }
	}
	let headerLineCount = fileHeaderComment.split(separator: "\n", omittingEmptySubsequences: false).count
	// file_length warning 門檻 400；超過才放（file_length 在 blanket 豁免清單、不需 enable）
	let needFileLength = headerLineCount + bodyLines.count > 400

	var disablesHeader = ""
	if needFileLength {
		disablesHeader += "\n\n// swiftlint:disable file_length\n// 原因：生成檔行數超門檻、對機械產出無指引意義。"
	}
	let paired = (needLineLength ? ["line_length"] : []) + (needVertical ? ["vertical_parameter_alignment"] : [])
	if !paired.isEmpty {
		disablesHeader += "\n\n// swiftlint:disable \(paired.joined(separator: " "))\n// 原因：生成的工廠簽名逐字對應原 case、行長 / 多行對齊對機械產出無指引意義。"
	}
	let enableFooter = paired.isEmpty ? "" : "\n// swiftlint:enable \(paired.joined(separator: " "))\n"

	let overloads = fileHeaderComment + disablesHeader + "\n\n" + body + enableFooter
	try overloads.write(toFile: outPath, atomically: true, encoding: .utf8)

	err("===== CODEGEN REPORT =====")
	err("Storage cases (已遷): \(allCases.count) ; wrap mode: \(wrapPrefix)")
	for caseInfo in allCases {
		err("  \(caseInfo.name)")
	}
	err("[synthesized defaults]")
	for record in storageRewriter.synthesized {
		err("  \(record.caseName).\(record.label): \(record.type) = \(record.injected)")
	}
	err("==========================")
}
