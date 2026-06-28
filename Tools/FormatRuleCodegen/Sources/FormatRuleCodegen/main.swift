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
// swiftformat 的 indent（含 indentStrings option）重排會破壞輸出——故只停 indent、模板縮排手動維持，
// 其餘格式規則照常套用。file_length：逐條規則 + 模板 + 報告 ~450 行屬正常規模、無品質意義。

import Foundation
import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder

// MARK: - 遷移帳本

// 已遷到型別安全 `.on` / `.off` 公開工廠的規則名。**逐規則 PR 往這裡加一條**。
// 不在此集合的規則出「舊式 `rule: Flag` 工廠」（過渡相容、Flag 暫保持 public）。
// 全部遷完後此集合 ＝ 全規則，收尾 PR 再把 Flag 降 internal、移除舊式路徑。
let migratedRules: Set<String> = []

// MARK: - 流程概述
//
// 讀真實 FormatRule.swift（struct FormatRule、其 internal 巢狀 enum Storage 為規則後端）->
//   1) 對「已遷移規則」的 Storage case 就地為缺 default 的非 rule param 合成預設
//      （讓 .off overload 可省略 option；目前只 fileHeader 需要、且要等它遷移時才合成），
//   2) 生成工廠（FormatRule+SafeOverloads.swift）：migrated → on/off/diagnostic；其餘 → 舊式 Flag 工廠。
//
// 4 個特例：
//   1. 非 rule 參數無預設（fileHeader 三 String）→ 遷移時 storage 端合成預設。
//   2. acronyms unnamed associated value → 工廠給合成內部名（value）positional 傳。
//   3. 5 個 deprecated case → 永遠舊式 Flag 工廠 + @available(deprecated, renamed:)，不遷 on/off。
//   4. 2 個 global-option case（typeBlankLines / wrapStringInterpolation、無 Flag）→ 單一 passthrough factory。

// MARK: - 模型

/// 單一 case 的一個參數：rule 旗標本身、或某條 option。
struct Param {

	/// 參數 label（rule, mode, allman, ...）；unnamed associated value 為空字串
	let label: String

	/// 型別文字（Flag, Toggle, BlankLineAfterSwitchCaseMode?, [String]?, Int?, String ...）
	let typeText: String

	/// 預設值文字（原樣保留、含 multi-line array literal）；無預設為 nil
	let defaultText: String?

	/// 是否為規則旗標本身（rule: Flag）——用來和 extra option 參數區分
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

	/// 是否標了 @available(deprecated)
	let isDeprecated: Bool

	/// @available(deprecated, renamed:) 的目標名；無則 nil
	let renamed: String?

	/// 是否已遷到 on/off 公開工廠（依遷移帳本）
	var isMigrated: Bool {
		migratedRules.contains(name)
	}

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

/// 走訪語法樹、把 Storage 的每個 EnumCaseDecl 解析成 CaseInfo。
final class CaseCollector: SyntaxVisitor {

	/// 收集到的所有 case
	var cases: [CaseInfo] = []

	// 範圍守衛：只收集 internal 巢狀 `enum Storage` 的 case。
	override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
		node.name.text == "Storage" ? .visitChildren : .skipChildren
	}

	override func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
		// 解析 case 上的 @available：判斷是否 deprecated、抓 renamed 目標
		var isDeprecated = false
		var renamed: String?
		for attr in node.attributes {
			guard case let .attribute(attribute) = attr,
				attribute.attributeName.trimmedDescription == "available" else { continue }
			let argDesc = attribute.arguments?.trimmedDescription ?? ""
			if argDesc.contains("deprecated") {
				isDeprecated = true
				if let cap = argDesc.firstMatch(of: #/renamed:\s*"([^"]+)"/#)?.output.1 {
					renamed = String(cap)
				}
			}
		}

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
			cases.append(CaseInfo(
				name: name,
				params: params,
				isDeprecated: isDeprecated,
				renamed: renamed
			))
		}
		return .skipChildren
	}
}

// MARK: - 分類

/// case 的四種形狀。
enum Shape: String {

	/// (rule: Flag) 只有 rule
	case pureFlag

	/// (rule: Flag, ...extra) 帶 option
	case flagPlusParams

	/// 無 rule（typeBlankLines / wrapStringInterpolation）
	case globalOption

	/// @available deprecated（永遠舊式 Flag 工廠）
	case deprecated
}

/// 依 deprecated / 有無 rule / 有無 extra option 判斷形狀。
func shape(_ caseInfo: CaseInfo) -> Shape {
	if caseInfo.isDeprecated { return .deprecated }
	if !caseInfo.hasRule { return .globalOption }
	return caseInfo.extraParams.isEmpty ? .pureFlag : .flagPlusParams
}

// MARK: - 合成預設（特例 1，僅對已遷移規則）

/// 為「無原始預設值的 extra param」合成一個預設，讓 .off overload 可省略全部 option。
func synthesizedDefault(forType typeText: String) -> String? {
	if typeText.hasSuffix("?") { return "nil" } // Optional -> nil
	switch typeText {
	case "String": return "\"\""
	case "Int": return "0"
	case "[String]": return "[]"
	default: return nil // 非 Optional enum 無安全合成預設
	}
}

// MARK: - storage enum 就地改寫（僅對已遷移規則補缺 default）

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

/// 一筆「無法安全合成預設」的紀錄（gate：型別不在 synthesizedDefault 支援範圍）。
struct SynthFailure {

	/// 出問題的 case 名
	let caseName: String

	/// 缺 default 又無法合成的參數 label
	let label: String

	/// 該參數型別文字
	let type: String
}

/// 用 SyntaxRewriter 對「已遷移規則」的 Storage case 補缺 default、保留所有 doc comment / trivia。
/// 不改 case 名（型別安全靠工廠 overload）。
final class StorageRewriter: SyntaxRewriter {

	/// 改寫過程中合成預設的紀錄
	var synthesized: [SynthRecord] = []

	/// 無法安全合成預設的 param 紀錄（gate：main 端據此報錯中止）
	var synthesisFailures: [SynthFailure] = []

	// 範圍守衛：只就地改寫 `enum Storage`。
	override func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
		guard node.name.text == "Storage" else { return DeclSyntax(node) }
		return super.visit(node)
	}

	override func visit(_ node: EnumCaseElementSyntax) -> EnumCaseElementSyntax {
		var node = node
		let caseName = node.name.text
		// 只對已遷移規則補預設（未遷移規則走舊式工廠、所有 param 顯式傳、不需 default）
		guard migratedRules.contains(caseName) else { return node }
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

/// storage case 建構引數列（enable：帶 extra 值；disable：只有 rule）
func renderStorageCall(_ caseInfo: CaseInfo, ruleArg: String, withOptions: Bool) -> String {
	var args: [String] = ["rule: \(ruleArg)"]
	if withOptions {
		for param in caseInfo.extraParams {
			args.append(param.label.isEmpty ? "value" : "\(param.label): \(param.label)")
		}
	}
	return args.joined(separator: ", ")
}

/// 舊式 `rule: Flag` 工廠（過渡相容）；deprecated 時附 @available。
func renderLegacyFactory(_ caseInfo: CaseInfo) -> String {
	let optionParams = renderOptionParams(caseInfo)
	let signature = (["rule: Flag"] + optionParams).joined(separator: ", ")
	let storageCall = renderStorageCall(caseInfo, ruleArg: "rule", withOptions: true)
	if caseInfo.isDeprecated {
		let renamedClause = caseInfo.renamed.map { ", renamed: \"\($0)\"" } ?? ""
		let renamedDoc = caseInfo.renamed.map { "改用 ``\($0)``" } ?? "已棄用"
		return """
		\t/// \(renamedDoc)（已棄用別名）
		\t@available(*, deprecated\(renamedClause))
		\tpublic static func \(caseInfo.name)(\(signature)) -> FormatRule {
		\t\t.init(.\(caseInfo.name)(\(storageCall)))
		\t}
		"""
	}
	return """
	\t/// 啟用（`.enable`）或停用（`.disable`）——過渡相容工廠，待遷型別安全 `.on` / `.off`
	\tpublic static func \(caseInfo.name)(\(signature)) -> FormatRule {
	\t\t.init(.\(caseInfo.name)(\(storageCall)))
	\t}
	"""
}

/// 已遷移規則的 on/off（+ diagnostic）工廠。
func renderMigratedFactory(_ caseInfo: CaseInfo) -> String {
	let onSignature = (["_ state: OnToken"] + renderOptionParams(caseInfo)).joined(separator: ", ")
	let onOverload = """
	\t/// 啟用 + 帶 option（option 預設＝原 SSK 簽名預設）
	\tpublic static func \(caseInfo.name)(\(onSignature)) -> FormatRule {
	\t\t.init(.\(caseInfo.name)(\(renderStorageCall(caseInfo, ruleArg: ".enable", withOptions: true))))
	\t}
	"""
	let offOverload = """
	\t/// 停用（不可帶 option）
	\tpublic static func \(caseInfo.name)(_ state: OffToken) -> FormatRule {
	\t\t.init(.\(caseInfo.name)(\(renderStorageCall(caseInfo, ruleArg: ".disable", withOptions: false))))
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

/// 依形狀 + 遷移帳本生成單一 case 的所有 overload 字串片段。
func renderOverloads(_ caseInfo: CaseInfo) -> String {
	switch shape(caseInfo) {
	case .deprecated:
		return renderLegacyFactory(caseInfo)
	case .globalOption:
		// 無 Flag——單一 passthrough factory（mode 預設保留），無 on/off。
		let params = caseInfo.extraParams
		let signature = params.isEmpty ? "mode: Never" : renderOptionParams(caseInfo).joined(separator: ", ")
		let storageArgs = params.isEmpty ? "mode: mode" : params.map { param in
			param.label.isEmpty ? "value" : "\(param.label): \(param.label)"
		}.joined(separator: ", ")
		return """
		\t/// 全域 option（無 rule Flag）：直接 passthrough，無 on/off 之分
		\tpublic static func \(caseInfo.name)(\(signature)) -> FormatRule {
		\t\t.init(.\(caseInfo.name)(\(storageArgs)))
		\t}
		"""
	case .pureFlag, .flagPlusParams:
		return caseInfo.isMigrated ? renderMigratedFactory(caseInfo) : renderLegacyFactory(caseInfo)
	}
}

// MARK: - 生成檔檔頭 + 報告 helper

/// 生成檔最頂端的檔頭。
let fileHeaderComment = """
//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

//  GENERATED by Tools/FormatRuleCodegen — DO NOT EDIT BY HAND.
//  規則工廠（過渡期 migrated → on/off、其餘 → 舊式 Flag）。改規則簽名請改 FormatRule.swift 的
//  Storage enum、遷移狀態改 migratedRules 後重跑 codegen。

// swiftformat:disable all
// 原因：本檔為 codegen 機械產出、簽名逐一對應 Storage 的原始 case（含 organizeDeclarations
// 等 8~22 參數的多 option 規則）。格式規則對「生成檔的可讀性」沒指引意義——要改格式請改
// codegen 模板、不手改本檔。故整檔停用 SwiftFormat。

// swiftlint:disable file_length
// 原因：全量生成 147 規則的工廠、檔案逾千行遠超門檻；file_length 對生成檔無意義。

// swiftlint:disable line_length vertical_parameter_alignment
// 原因：生成的工廠簽名逐字對應原 case、可能破 120、多行參數不垂直對齊；這些格式類規則對生成檔
// 無指引意義。需停的其他 swiftlint 規則隨更複雜規則加進此 disable。
"""

/// 寫一行到 stderr（codegen 報告專用、不污染生成檔）。
func err(_ string: String) {
	FileHandle.standardError.write(Data((string + "\n").utf8))
}

// MARK: - 主流程

// 1. 解析參數
let arguments = CommandLine.arguments
guard arguments.count >= 3 else {
	FileHandle.standardError.write(
		Data("usage: FormatRuleCodegen <FormatRule.swift path> <output dir>\n".utf8)
	)
	exit(2)
}
let formatRulePath = arguments[1]
let outDir = arguments[2]

// 2. 讀取並解析 FormatRule.swift
guard let source = try? String(contentsOfFile: formatRulePath, encoding: .utf8) else {
	FileHandle.standardError.write(Data("cannot read \(formatRulePath)\n".utf8))
	exit(1)
}
let tree = Parser.parse(source: source)

// 3. Storage enum 就地改寫（僅對已遷移規則補 default）、寫回原檔
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

// 4. 從改寫後的 tree 收集 case
let collector = CaseCollector(viewMode: .sourceAccurate)
collector.walk(rewrittenTree)
let allCases = collector.cases

// 5. 生成工廠檔（全量：每個 Storage case 都出工廠）
var overloads = fileHeaderComment + "\n\nextension FormatRule {\n\n"
for caseInfo in allCases {
	let body = renderOverloads(caseInfo)
	guard !body.isEmpty else { continue }
	overloads += "\t// MARK: \(caseInfo.name)\n\n"
	overloads += body + "\n\n"
}
if overloads.hasSuffix("\n\n") {
	overloads.removeLast()
}
overloads += "}\n\n// swiftlint:enable line_length vertical_parameter_alignment\n"
try overloads.write(toFile: "\(outDir)/FormatRule+SafeOverloads.swift", atomically: true, encoding: .utf8)

// 6. 統計報告
let migratedCount = allCases.filter(\.isMigrated).count
var counts: [Shape: Int] = [:]
for caseInfo in allCases {
	counts[shape(caseInfo), default: 0] += 1
}

err("===== CODEGEN REPORT =====")
err("storage cases: \(allCases.count) total")
err("migrated (on/off): \(migratedCount) ; legacy (rule: Flag): \(allCases.count - migratedCount - (counts[.globalOption] ?? 0))")
for kind: Shape in [.pureFlag, .flagPlusParams, .globalOption, .deprecated] {
	err("  \(kind.rawValue): \(counts[kind] ?? 0)")
}
err("")
err("migratedRules: \(migratedRules.sorted().joined(separator: ", "))")
err("")
err("[synthesized storage defaults]")
for record in storageRewriter.synthesized {
	err("  \(record.caseName).\(record.label): \(record.type) = \(record.injected)")
}
err("==========================")
