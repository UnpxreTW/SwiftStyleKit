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
// 其餘格式規則照常套用。file_length：逐條規則 + 模板 + 報告 ~400 行屬正常規模、無品質意義。

import Foundation
import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder

// MARK: - 流程概述
//
// 讀真實 FormatRule.swift ->
//   1) 就地把 storage enum 的 case 名加 `_` 前綴（SyntaxRewriter、保留所有 doc comment / trivia），
//      並對 `fileHeader` 三個無預設 String param 合成 `= ""` 預設、
//   2) 生成型別安全 enable/disable/diagnostic overloads（FormatRule+SafeOverloads.swift）。
//
// 4 個特例（不處理會編不過、細節見各 render 站點的內嵌註解）：
//   1. 非 rule 參數無預設的 case（fileHeader 三個 String）→ storage 端合成預設。
//   2. acronyms 的 unnamed associated value → storage 用裸型別、enable 給合成內部名（_value）positional 傳。
//   3. 5 個 deprecated case → 跳過、保留原 @available(deprecated, renamed:)。
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

/// 從 FormatRule enum 解析出的單一 case。
struct CaseInfo {

	/// 規則 case 名（public API 名、已去掉 storage 的 `_` 前綴）
	let name: String

	/// case 的所有參數（含 rule 旗標與 extra option）
	let params: [Param]

	/// 是否標了 @available(deprecated)
	let isDeprecated: Bool

	/// @available(deprecated, renamed:) 的目標名；無則 nil
	let renamed: String?

	/// 是否含 rule 旗標（globalOption case 無）
	var hasRule: Bool {
		params.contains { $0.isRule }
	}

	/// 除 rule 旗標外的 option 參數
	var extraParams: [Param] {
		params.filter { !$0.isRule }
	}
}

// MARK: - 找到 enum FormatRule、走訪 case

/// 走訪語法樹、把每個 EnumCaseDecl 解析成 CaseInfo。
final class CaseCollector: SyntaxVisitor {

	/// 收集到的所有 case
	var cases: [CaseInfo] = []

	// 範圍守衛（gate 2）：codegen 讀單一 FormatRule.swift；只收集 `enum FormatRule`
	// 的 case，未來若在同檔加 helper enum 才不會誤收其 case。
	override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
		node.name.text == "FormatRule" ? .visitChildren : .skipChildren
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
			// 已 `_` 前綴的 storage case 還原成 public API 名（讓 codegen 可 re-run）
			let rawName = element.name.text
			let name = rawName.hasPrefix("_") ? String(rawName.dropFirst()) : rawName
			// 逐一收集參數（label / 型別 / 預設值文字）
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

/// case 的四種形狀，決定生成哪些 overload。
enum Shape: String {

	/// (rule: Flag) 只有 rule
	case pureFlag

	/// (rule: Flag, ...extra) 帶 option
	case flagPlusParams

	/// 無 rule（typeBlankLines / wrapStringInterpolation）
	case globalOption

	/// @available deprecated（不生成 token 拆分）
	case deprecated
}

/// 依 deprecated / 有無 rule / 有無 extra option 判斷形狀。
func shape(_ caseInfo: CaseInfo) -> Shape {
	if caseInfo.isDeprecated { return .deprecated }
	if !caseInfo.hasRule { return .globalOption }
	return caseInfo.extraParams.isEmpty ? .pureFlag : .flagPlusParams
}

// MARK: - 合成預設（特例 1）

/// 為「無原始預設值的 extra param」合成一個預設，讓 disable factory 可省略全部 option。
/// 真實 enum 裡 fileHeader 的 header/dateFormat/timeZone 無 default、若不補 storage 端
/// disable overload 會缺引數編譯 fail——此即必須處理的 edge。
func synthesizedDefault(forType typeText: String) -> String? {
	if typeText.hasSuffix("?") { return "nil" } // Optional -> nil
	switch typeText {
	case "String": return "\"\""
	case "Int": return "0"
	case "[String]": return "[]"
	default: return nil // 非 Optional enum 無安全合成預設
	}
}

// MARK: - storage enum 就地改寫（`_` 前綴 + fileHeader 合成預設）

/// 一筆「被合成預設」的紀錄（供結尾報告列出哪些 param 被補了預設）。
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

/// 一筆「無法安全合成預設」的紀錄（gate 3：型別不在 synthesizedDefault 支援範圍）。
struct SynthFailure {

	/// 出問題的 case 名
	let caseName: String

	/// 缺 default 又無法合成的參數 label
	let label: String

	/// 該參數型別文字
	let type: String
}

/// 用 SyntaxRewriter 只改 case 名與缺 default 的 param、保留所有 doc comment / trivia。
final class StorageRewriter: SyntaxRewriter {

	/// 改寫過程中合成預設的紀錄
	var synthesized: [SynthRecord] = []

	/// 無法安全合成預設的 param 紀錄（gate 3：main 端據此報錯中止）
	var synthesisFailures: [SynthFailure] = []

	// 範圍守衛（gate 2）：只就地改寫 `enum FormatRule`；其他 enum（未來在同檔加的
	// helper）原樣返回、不遞迴改寫其 case，避免 case 名被默默加 `_` 前綴寫壞 source。
	override func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
		guard node.name.text == "FormatRule" else { return DeclSyntax(node) }
		return super.visit(node)
	}

	override func visit(_ node: EnumCaseElementSyntax) -> EnumCaseElementSyntax {
		var node = node
		let rawName = node.name.text
		// idempotent：已 `_` 前綴的不再加（讓 codegen 可重複 re-run 不雙前綴）
		let originalName = rawName.hasPrefix("_") ? String(rawName.dropFirst()) : rawName
		// case 名加 `_` 前綴（保留 leading/trailing trivia）
		node.name = TokenSyntax.identifier("_" + originalName)
			.with(\.leadingTrivia, node.name.leadingTrivia)
			.with(\.trailingTrivia, node.name.trailingTrivia)

		// 對缺 default 的非 rule param 合成 default（特例 1：fileHeader）
		guard var paramClause = node.parameterClause else { return node }
		var newParams = paramClause.parameters
		for index in newParams.indices {
			let param = newParams[index]
			let label = param.firstName?.text ?? ""
			let typeText = param.type.trimmedDescription
			let isRule = (typeText == "Flag" && label == "rule")
			// rule 旗標、或已有原始 default 的 param 不需合成
			guard !isRule, param.defaultValue == nil else { continue }
			// gate 3：非 rule param 無原始 default、但型別無法安全合成預設（非 Optional 的
			// Bool/Toggle/Double 等）→ 記錄失敗、main 端報錯中止，別讓 disable overload
			// 缺引數、把編譯錯誤甩給看不懂 codegen 的下游。
			guard let synth = synthesizedDefault(forType: typeText) else {
				synthesisFailures.append(SynthFailure(
					caseName: originalName,
					label: label,
					type: typeText
				))
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
			synthesized.append(SynthRecord(
				caseName: originalName,
				label: label,
				type: typeText,
				injected: synth
			))
		}
		paramClause.parameters = newParams
		node.parameterClause = paramClause
		return node
	}
}

// MARK: - overload 簽名與 body 片段

/// enable overload 的參數列（extra params 保留 default、call-site 可省略）
func renderEnableSignature(_ caseInfo: CaseInfo) -> String {
	var parts: [String] = ["rule: EnableToken"]
	for param in caseInfo.extraParams {
		// unnamed param 需要一個 internal 名字才能在 body 引用（特例 2：acronyms）
		let label = param.label.isEmpty ? "_ value" : param.label
		let def = param.defaultText.map { " = \($0)" } ?? ""
		parts.append("\(label): \(param.typeText)\(def)")
	}
	return parts.joined(separator: ", ")
}

/// storage case 的建構引數列（enable：帶上 extra 值；disable：只有 rule）
func renderStorageCall(_ caseInfo: CaseInfo, enable: Bool) -> String {
	var args: [String] = [enable ? "rule: .enable" : "rule: .disable"]
	if enable {
		for param in caseInfo.extraParams {
			if param.label.isEmpty {
				args.append("value") // 特例 2：positional 傳
			} else {
				args.append("\(param.label): \(param.label)")
			}
		}
	}
	return args.joined(separator: ", ")
}

/// 依形狀生成單一 case 的所有 overload 字串片段（含 load-bearing `\t` 縮排、直接寫進生成檔）。
// swiftlint:disable:next function_body_length
func renderOverloads(_ caseInfo: CaseInfo) -> String {
	switch shape(caseInfo) {
	case .deprecated:
		// 特例 3：不做 enable/disable token 拆分（已棄用、不值得型別安全治理），
		// 但保留 backward-compat 的 `rule: Flag` 單一 factory + @available(deprecated, renamed:)，
		// 讓既有 deprecated alias call site（展開仍用舊 flag 名）持續可用。
		var signatureParts: [String] = ["rule: Flag"]
		var forwardArgs: [String] = ["rule: rule"]
		for param in caseInfo.extraParams {
			let label = param.label.isEmpty ? "_ value" : param.label
			let def = param.defaultText.map { " = \($0)" } ?? ""
			signatureParts.append("\(label): \(param.typeText)\(def)")
			forwardArgs.append(param.label.isEmpty ? "value" : "\(param.label): \(param.label)")
		}
		let renamedClause = caseInfo.renamed.map { ", renamed: \"\($0)\"" } ?? ""
		return """
		\t@available(*, deprecated\(renamedClause))
		\tpublic static func \(caseInfo.name)(\(signatureParts.joined(separator: ", "))) -> FormatRule {
		\t\t._\(caseInfo.name)(\(forwardArgs.joined(separator: ", ")))
		\t}
		"""
	case .globalOption:
		// 特例 4：無 Flag——維持單一 passthrough factory（mode 預設保留），無 enable/disable/diagnostic。
		// gate 4：globalOption 可能不只一個 param（未來 typeBlankLines 加第二 option）；
		// 逐一展開簽名與 storage 引數、別只取 first。
		let params = caseInfo.extraParams
		let signature = params.isEmpty ? "mode: Never" : params.map { param in
			let label = param.label.isEmpty ? "_ value" : param.label
			let def = param.defaultText.map { " = \($0)" } ?? ""
			return "\(label): \(param.typeText)\(def)"
		}.joined(separator: ", ")
		let storageArgs = params.isEmpty ? "mode: mode" : params.map { param in
			param.label.isEmpty ? "value" : "\(param.label): \(param.label)"
		}.joined(separator: ", ")
		return """
		\t/// 全域 option（無 rule Flag）：直接 passthrough，無 enable/disable 之分
		\tpublic static func \(caseInfo.name)(\(signature)) -> FormatRule {
		\t\t._\(caseInfo.name)(\(storageArgs))
		\t}
		"""
	case .pureFlag:
		// enable + disable，無 diagnostic
		return """
		\t/// 啟用
		\tpublic static func \(caseInfo.name)(rule: EnableToken) -> FormatRule {
		\t\t._\(caseInfo.name)(rule: .enable)
		\t}

		\t/// 停用
		\tpublic static func \(caseInfo.name)(rule: DisableToken) -> FormatRule {
		\t\t._\(caseInfo.name)(rule: .disable)
		\t}
		"""
	case .flagPlusParams:
		// 1. enable + 參數（option 預設＝原 SSK 簽名預設）
		let enableOverload = """
		\t/// 啟用 + 帶 option（option 預設＝原 SSK 簽名預設）
		\tpublic static func \(caseInfo.name)(\(renderEnableSignature(caseInfo))) -> FormatRule {
		\t\t._\(caseInfo.name)(\(renderStorageCall(caseInfo, enable: true)))
		\t}
		"""
		// 2. disable（無額外參數）
		let disableOverload = """
		\t/// 停用（不可帶 option）
		\tpublic static func \(caseInfo.name)(rule: DisableToken) -> FormatRule {
		\t\t._\(caseInfo.name)(\(renderStorageCall(caseInfo, enable: false)))
		\t}
		"""
		// 3. disable + 參數診斷 overload（@available unavailable、吐客製訊息）
		let diagnosticParams = caseInfo.extraParams.map { param -> String in
			let label = param.label.isEmpty ? "_ value" : param.label
			let def = param.defaultText.map { " = \($0)" } ?? ""
			return "\(label): \(param.typeText)\(def)"
		}.joined(separator: ", ")
		let diagnosticOverload = """
		\t@available(*, unavailable, message: "rule 為 .disable 時不可帶 option（option 只在 .enable 有效）")
		\tpublic static func \(caseInfo.name)(rule: DisableToken, \(diagnosticParams)) -> FormatRule {
		\t\tfatalError("unavailable")
		\t}
		"""
		return [enableOverload, disableOverload, diagnosticOverload].joined(separator: "\n\n")
	}
}

// MARK: - 生成檔檔頭 + 報告 helper

/// 生成檔最頂端的檔頭（含 license 與整檔停用 lint/format 的理由）。
let fileHeaderComment = """
//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT
//
//  GENERATED by Tools/FormatRuleCodegen — DO NOT EDIT BY HAND.
//  型別安全 enable/disable/diagnostic overloads。改規則簽名請改 FormatRule.swift 後重跑 codegen。

// swiftformat:disable all
// swiftlint:disable all
// 原因：本檔為 codegen 機械產出、簽名逐一對應 FormatRule 的原始 case（含 organizeDeclarations
// 等 8~22 參數的多 option 規則）。file_length / function_parameter_count / line_length /
// vertical_parameter_alignment / wrap 等風格規則對「生成檔的可讀性」沒指引意義——要改格式請改
// codegen 模板、不手改本檔。故整檔同時停用 SwiftLint 與 SwiftFormat。
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
let formatRulePath = arguments[1] // 來源 FormatRule.swift 路徑
let outDir = arguments[2] // 生成檔輸出目錄

// 2. 讀取並解析 FormatRule.swift
guard let source = try? String(contentsOfFile: formatRulePath, encoding: .utf8) else {
	FileHandle.standardError.write(Data("cannot read \(formatRulePath)\n".utf8))
	exit(1)
}
let tree = Parser.parse(source: source)

// 3. storage enum 就地改寫（`_` 前綴 + fileHeader 合成預設）、寫回原檔
let storageRewriter = StorageRewriter()
let rewrittenTree = storageRewriter.visit(tree)
// gate 3：有無法安全合成預設的 param → 報錯中止（此時尚未寫回 source、不留壞檔）
if !storageRewriter.synthesisFailures.isEmpty {
	err("ERROR: 以下 param 無原始 default 且型別無法安全合成預設（gate 3）：")
	for failure in storageRewriter.synthesisFailures {
		err("  \(failure.caseName).\(failure.label): \(failure.type)")
	}
	err("請在 synthesizedDefault(forType:) 補上該型別、或在 FormatRule 給該 param 預設值。")
	exit(1)
}
try rewrittenTree.description.write(toFile: formatRulePath, atomically: true, encoding: .utf8)

// 4. 從改寫後的 tree 收集 case：storage 合成的 default（如 fileHeader 的 `= ""`）也進到
//    caseInfo.defaultText，enable / 診斷 overload 簽名才帶得上、連無原始 default 的 param 一起覆蓋
let collector = CaseCollector(viewMode: .sourceAccurate)
collector.walk(rewrittenTree)
let allCases = collector.cases

// 5. 生成 overload 檔
var overloads = fileHeaderComment + "\n\nextension FormatRule {\n\n"
for caseInfo in allCases {
	let body = renderOverloads(caseInfo)
	guard !body.isEmpty else { continue }
	overloads += "\t// MARK: \(caseInfo.name)\n\n"
	overloads += body + "\n\n"
}
overloads += "}\n"
try overloads.write(toFile: "\(outDir)/FormatRule+SafeOverloads.swift", atomically: true, encoding: .utf8)

// 6. 統計報告（stderr，不污染檔案）
var counts: [Shape: Int] = [:]
for caseInfo in allCases {
	counts[shape(caseInfo), default: 0] += 1
}
var overloadCount = 0
for caseInfo in allCases {
	switch shape(caseInfo) {
	case .pureFlag: overloadCount += 2
	case .flagPlusParams: overloadCount += 3
	case .globalOption: overloadCount += 1
	case .deprecated: overloadCount += 1 // backward-compat 單一 deprecated factory
	}
}

err("===== CODEGEN REPORT =====")
err("total enum cases parsed: \(allCases.count)")
for kind: Shape in [.pureFlag, .flagPlusParams, .globalOption, .deprecated] {
	err("  \(kind.rawValue): \(counts[kind] ?? 0)")
}

err("total generated overloads: \(overloadCount)")
err("")
err("[special case 1] synthesized storage defaults (param lacking original default):")
for record in storageRewriter.synthesized {
	err("  \(record.caseName).\(record.label): \(record.type) = \(record.injected)")
}

err("")
err("[special case 2] unnamed associated values:")
for caseInfo in allCases where shape(caseInfo) == .flagPlusParams {
	for param in caseInfo.extraParams where param.label.isEmpty {
		err("  \(caseInfo.name).<unnamed>: \(param.typeText)")
	}
}

err("")
err("[special case 3] deprecated cases (backward-compat Flag factory, no token split):")
for caseInfo in allCases where caseInfo.isDeprecated {
	err("  \(caseInfo.name) -> renamed: \(caseInfo.renamed ?? "?")")
}

err("")
err("[special case 4] global-option cases (passthrough factory):")
for caseInfo in allCases where shape(caseInfo) == .globalOption {
	err("  \(caseInfo.name)")
}

err("==========================")
