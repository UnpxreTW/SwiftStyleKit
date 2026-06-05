// swiftformat:disable all
// swiftlint:disable all
// 原因：本檔是 FormatRule overload 生成的一次性 codegen dev 工具、住在獨立 package（Tools/FormatRuleCodegen、
// swift-syntax 依賴只在這、反 SwiftSyntax 傳染）。內含的多行 string 模板帶 load-bearing 的 `\t`
// 縮排（直接寫進生成檔），讓主 package 的 swiftformat 規則自動重排會破壞生成輸出。此工具不參與
// 主 package 的格式治理、故整檔停用 SwiftFormat 與 SwiftLint。

import Foundation
import SwiftParser
import SwiftSyntax
import SwiftSyntaxBuilder

// MARK: - 一次性 codegen for FormatRule 型別安全 overload
//
// 讀真實 FormatRule.swift ->
//   1) 就地把 storage enum 的 case 名加 `_` 前綴（SyntaxRewriter、保留所有 doc comment /
//      trivia），並對 `fileHeader` 三個無預設 String param 合成 `= ""` 預設、
//   2) 生成型別安全 enable/disable/diagnostic overloads（FormatRule+SafeOverloads.swift）。
//
// 4 個特例（不處理會編不過）：
//   1. 非 rule 參數無預設的 case（fileHeader 三個 String）→ storage 端合成預設、
//      讓 disable overload 可省略全部 option。
//   2. acronyms 的 unnamed associated value → storage 用裸型別、enable overload 給合成
//      內部名（_value）、positional 傳。
//   3. 5 個 deprecated case → 跳過、不生 overload、保留原 @available(deprecated, renamed:)。
//   4. 2 個 global-option case（typeBlankLines / wrapStringInterpolation、無 Flag）→
//      生單一 passthrough factory、無 enable/disable/diagnostic。

let arguments = CommandLine.arguments
guard arguments.count >= 3 else {
	FileHandle.standardError.write(
		"usage: FormatRuleCodegen <FormatRule.swift path> <output dir>\n".data(using: .utf8)!
	)
	exit(2)
}
let formatRulePath = arguments[1]
let outDir = arguments[2]

guard let source = try? String(contentsOfFile: formatRulePath, encoding: .utf8) else {
	FileHandle.standardError.write("cannot read \(formatRulePath)\n".data(using: .utf8)!)
	exit(1)
}

let tree = Parser.parse(source: source)

// MARK: 模型

struct Param {
	let label: String          // 參數 label（rule, mode, allman, ...）；unnamed = ""
	let typeText: String       // 型別文字（Flag, Toggle, BlankLineAfterSwitchCaseMode?, [String]?, Int?, String）
	let defaultText: String?   // 預設值文字（原樣保留、含 multi-line array literal）
	var isRule: Bool { typeText == "Flag" && label == "rule" }
}

struct CaseInfo {
	let name: String
	let params: [Param]
	let isDeprecated: Bool
	let renamed: String?       // @available(deprecated, renamed:) 目標
	var hasRule: Bool { params.contains { $0.isRule } }
	var extraParams: [Param] { params.filter { !$0.isRule } }
}

// MARK: 找到 enum FormatRule、走訪 case

final class CaseCollector: SyntaxVisitor {
	var cases: [CaseInfo] = []

	override func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
		var isDeprecated = false
		var renamed: String? = nil
		for attr in node.attributes {
			guard case let .attribute(attribute) = attr,
				attribute.attributeName.trimmedDescription == "available" else { continue }
			let argDesc = attribute.arguments?.trimmedDescription ?? ""
			if argDesc.contains("deprecated") {
				isDeprecated = true
				if let range = argDesc.range(of: "renamed:") {
					let tail = argDesc[range.upperBound...]
					if let open = tail.firstIndex(of: "\""),
						let close = tail[tail.index(after: open)...].firstIndex(of: "\"") {
						renamed = String(tail[tail.index(after: open)..<close])
					}
				}
			}
		}

		for element in node.elements {
			// 已 `_` 前綴的 storage case 還原成 public API 名（讓 codegen 可 re-run）
			let rawName = element.name.text
			let name = rawName.hasPrefix("_") ? String(rawName.dropFirst()) : rawName
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

// MARK: 分類

enum Shape: String {
	case pureFlag            // (rule: Flag) 只有 rule
	case flagPlusParams      // (rule: Flag, ...extra)
	case globalOption        // 無 rule（typeBlankLines / wrapStringInterpolation）
	case deprecated          // @available deprecated（不生成）
}

func shape(_ caseInfo: CaseInfo) -> Shape {
	if caseInfo.isDeprecated { return .deprecated }
	if !caseInfo.hasRule { return .globalOption }
	return caseInfo.extraParams.isEmpty ? .pureFlag : .flagPlusParams
}

// MARK: 合成預設（特例 1）

// 為「無原始預設值的 extra param」合成一個預設，讓 disable factory 可省略全部 option。
// 真實 enum 裡 fileHeader 的 header/dateFormat/timeZone 無 default、若不補 storage 端
// disable overload 會缺引數編譯 fail——此即必須處理的 edge。
func synthesizedDefault(forType typeText: String) -> String? {
	if typeText.hasSuffix("?") { return "nil" }              // Optional -> nil
	switch typeText {
	case "String": return "\"\""
	case "Int": return "0"
	case "[String]": return "[]"
	default: return nil                                       // 非 Optional enum 無安全合成預設
	}
}

// MARK: storage enum 就地改寫（`_` 前綴 + fileHeader 合成預設）

// 用 SyntaxRewriter 只改 case 名與缺 default 的 param、保留所有 doc comment / trivia。
struct SynthRecord {
	let caseName: String
	let label: String
	let type: String
	let injected: String
}

final class StorageRewriter: SyntaxRewriter {
	var synthesized: [SynthRecord] = []

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
			guard !isRule, param.defaultValue == nil,
				let synth = synthesizedDefault(forType: typeText) else { continue }
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

let storageRewriter = StorageRewriter()
let rewrittenTree = storageRewriter.visit(tree)
try rewrittenTree.description.write(toFile: formatRulePath, atomically: true, encoding: .utf8)

// 從改寫後的 tree 收集 case：storage 合成的 default（如 fileHeader 的 `= ""`）也進到
// caseInfo.defaultText，enable / 診斷 overload 簽名才帶得上、連無原始 default 的 param 一起覆蓋
let collector = CaseCollector(viewMode: .sourceAccurate)
collector.walk(rewrittenTree)
let allCases = collector.cases

// MARK: overload 簽名與 body 片段

// enable overload 的參數列（extra params 保留 default、call-site 可省略）
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

// storage case 的建構引數列（enable：帶上 extra 值；disable：只有 rule）
func renderStorageCall(_ caseInfo: CaseInfo, enable: Bool) -> String {
	var args: [String] = [enable ? "rule: .enable" : "rule: .disable"]
	if enable {
		for param in caseInfo.extraParams {
			if param.label.isEmpty {
				args.append("value")                          // 特例 2：positional 傳
			} else {
				args.append("\(param.label): \(param.label)")
			}
		}
	}
	return args.joined(separator: ", ")
}

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
		// 特例 4：無 Flag——維持單一 passthrough factory（mode 預設保留），無 enable/disable/diagnostic
		let param = caseInfo.extraParams.first
		let label = param?.label ?? "mode"
		let typeText = param?.typeText ?? "Never"
		let def = param?.defaultText.map { " = \($0)" } ?? ""
		return """
		\t/// 全域 option（無 rule Flag）：直接 passthrough，無 enable/disable 之分
		\tpublic static func \(caseInfo.name)(\(label): \(typeText)\(def)) -> FormatRule {
		\t\t._\(caseInfo.name)(\(label): \(label))
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

// MARK: 輸出 overload 檔

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

var overloads = fileHeaderComment + "\n\nextension FormatRule {\n\n"
for caseInfo in allCases {
	let body = renderOverloads(caseInfo)
	guard !body.isEmpty else { continue }
	overloads += "\t// MARK: \(caseInfo.name)\n\n"
	overloads += body + "\n\n"
}
overloads += "}\n"
try overloads.write(toFile: "\(outDir)/FormatRule+SafeOverloads.swift", atomically: true, encoding: .utf8)

// MARK: 統計報告（stderr，不污染檔案）

func err(_ string: String) { FileHandle.standardError.write((string + "\n").data(using: .utf8)!) }

var counts: [Shape: Int] = [:]
for caseInfo in allCases { counts[shape(caseInfo), default: 0] += 1 }

var overloadCount = 0
for caseInfo in allCases {
	switch shape(caseInfo) {
	case .pureFlag: overloadCount += 2
	case .flagPlusParams: overloadCount += 3
	case .globalOption: overloadCount += 1
	case .deprecated: overloadCount += 1   // backward-compat 單一 deprecated factory
	}
}

err("===== CODEGEN REPORT =====")
err("total enum cases parsed: \(allCases.count)")
for sh: Shape in [.pureFlag, .flagPlusParams, .globalOption, .deprecated] {
	err("  \(sh.rawValue): \(counts[sh] ?? 0)")
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
