//
//  SwiftStyleFormat
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import Foundation
import PackagePlugin

@main
struct SwiftStyleFormat: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) throws {
        var extractor = ArgumentExtractor(arguments)
        let selectedTargets = extractor.extractOption(named: "target")
        guard let headerSPDX = extractHeaderSPDX(from: &extractor) else { return }
        let remaining = extractor.remainingArguments

        let targets: [Target]
        if selectedTargets.isEmpty {
            targets = context.package.targets
        } else {
            targets = try context.package.targets(named: selectedTargets)
        }

        let tool = try context.tool(named: "swiftformat")
        let inputs = headerInputs(directory: context.package.directory, headerSPDXOverride: headerSPDX.value)
        try requireHolder(inputs)
        for target in targets {
            guard let module = target as? SourceModuleTarget else { continue }
            let injected: [String] = [
                "--disable", "all",
                "--swiftversion", "6.2",
                "--symlinks", "follow"
            ] + FormatRule.allToCommand + headerArguments(targetName: module.name, inputs: inputs)
            try runSwiftFormat(
                executable: tool.path,
                paths: [module.directory.string],
                arguments: injected + remaining
            )
        }
    }

    /// 解析專案根目錄的授權與版權來源檔，組出檔頭所需輸入
    ///
    /// `headerSPDXOverride` 存在時跳過 `LICENSE` 的授權自動辨識、直接以指定 SPDX ID
    /// 視為已辨識授權（持有人來源檔照常解析）；用於辨識不到的授權與 `LicenseRef-*`
    /// 自訂授權的逃生梯。
    private func headerInputs(directory: Path, headerSPDXOverride: String? = nil) -> HeaderInputs {
        let (license, licenseHolder) = licenseInfo(directory: directory)
        return HeaderInputs(
            license: headerSPDXOverride.map { .recognized(name: $0, spdxID: $0) } ?? license,
            licenseHolder: licenseHolder,
            noticeHolder: noticeHolder(directory: directory),
            authors: readAuthors(directory: directory)
        )
    }

    /// 取出並驗證 `--header-spdx`；未指定回 `.init(value: nil)`、非法時報錯回 `nil`（呼叫端應中止）
    private func extractHeaderSPDX(from extractor: inout ArgumentExtractor) -> HeaderSPDXOverride? {
        guard let id = extractor.extractOption(named: "header-spdx").last else {
            return HeaderSPDXOverride(value: nil)
        }
        guard FileHeaderBuilder.isValidSPDXID(id) else {
            Diagnostics.error("--header-spdx 不是合法的單一 SPDX 授權識別字：\(id)（接受 idstring 或 LicenseRef-*、不接受複合運算式）")
            return nil
        }
        return HeaderSPDXOverride(value: id)
    }

    /// `--header-spdx` 的解析結果——`value == nil` 表未指定、走 `LICENSE` 自動辨識
    private struct HeaderSPDXOverride {

        let value: String?
    }

    /// FSL 授權需有版權持有人——`LICENSE` Notice 段未填 Copyright 行且無 `AUTHORS` 時
    /// 報錯擋下，不產出零版權行的殘缺檔頭（FSL 官方模板以 we/us 指稱授權人、
    /// 易漏填 Notice 段）
    /// 缺版權持有人時 throw（SwiftPM 印錯誤 + 非零失敗，比 `Diagnostics.error` + return 可靠）
    private func requireHolder(_ inputs: HeaderInputs) throws {
        guard case let .recognized(_, spdxID) = inputs.license else { return }
        let noHolder = inputs.licenseHolder == nil && inputs.authors.isEmpty
        if spdxID.hasPrefix("FSL-1.1"), noHolder {
            throw HeaderError(description: "FSL 授權需有版權持有人：請在 LICENSE 的 Notice 段填 Copyright 行、或提供 AUTHORS 檔")
        }
        if spdxID == "MPL-2.0", noHolder {
            throw HeaderError(description: "MPL-2.0 每檔需版權持有人（REUSE 合規要求）：請提供 AUTHORS 檔、或在 LICENSE 填 Copyright 行")
        }
    }

    /// plugin 中止用錯誤：`description` 即 SwiftPM 顯示的訊息
    private struct HeaderError: Error, CustomStringConvertible {
        let description: String
    }

    /// 找專案根目錄的 `LICENSE`，解析授權類型與版權持有人（持有人型授權的來源）
    private func licenseInfo(directory: Path) -> (license: FileHeaderBuilder.LicenseInfo, holder: String?) {
        for name in ["LICENSE", "LICENSE.md", "LICENSE.txt"] {
            let url = URL(fileURLWithPath: directory.string + "/" + name)
            guard let text = try? String(contentsOf: url, encoding: .utf8) else { continue }
            let holder = FileHeaderBuilder.copyrightHolder(in: text)
            if let license = FileHeaderBuilder.recognizeLicense(in: text) {
                return (.recognized(name: license.name, spdxID: license.spdxID), holder)
            }
            return (.unrecognized, holder)
        }
        return (.missing, nil)
    }

    /// 找專案根目錄的 `NOTICE` 並解析版權持有人（Apache-2.0 的來源）
    private func noticeHolder(directory: Path) -> String? {
        for name in ["NOTICE", "NOTICE.md", "NOTICE.txt"] {
            let url = URL(fileURLWithPath: directory.string + "/" + name)
            guard let text = try? String(contentsOf: url, encoding: .utf8) else { continue }
            return FileHeaderBuilder.copyrightHolder(in: text)
        }
        return nil
    }

    /// 找專案根目錄的 `AUTHORS` 並抓出版權持有人清單（MPL-2.0 的來源）
    private func readAuthors(directory: Path) -> [String] {
        for name in ["AUTHORS", "AUTHORS.md", "AUTHORS.txt"] {
            let url = URL(fileURLWithPath: directory.string + "/" + name)
            guard let text = try? String(contentsOf: url, encoding: .utf8) else { continue }
            return FileHeaderBuilder.authors(in: text)
        }
        return []
    }

    /// 為單一 target 組出 `fileHeader` 規則的 CLI 參數
    private func headerArguments(targetName: String, inputs: HeaderInputs) -> [String] {
        let header = FileHeaderBuilder.header(
            targetName: targetName,
            licenseHolder: inputs.licenseHolder,
            noticeHolder: inputs.noticeHolder,
            authors: inputs.authors,
            license: inputs.license
        )
        let rule = FormatRule.fileHeader(
            rule: .enable,
            header: header,
            dateFormat: "system",
            timeZone: "system"
        )
        return rule.cliArguments
    }

    private func runSwiftFormat(executable: Path, paths: [String], arguments: [String]) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: executable.string)
        process.arguments = paths + arguments
        try process.run()
        process.waitUntilExit()
        if process.terminationStatus != 0 {
            throw HeaderError(description: "swiftformat 失敗 (exit \(process.terminationStatus))")
        }
    }

    /// 檔頭組裝所需的解析結果（授權型別 + 各來源的版權持有人）
    private struct HeaderInputs {
        let license: FileHeaderBuilder.LicenseInfo
        let licenseHolder: String?
        let noticeHolder: String?
        let authors: [String]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SwiftStyleFormat: XcodeCommandPlugin {
    func performCommand(context: XcodePluginContext, arguments: [String]) throws {
        var extractor = ArgumentExtractor(arguments)
        let selectedTargets = extractor.extractOption(named: "target")
        guard let headerSPDX = extractHeaderSPDX(from: &extractor) else { return }
        let remaining = extractor.remainingArguments

        let tool = try context.tool(named: "swiftformat")
        let inputs = headerInputs(directory: context.xcodeProject.directory, headerSPDXOverride: headerSPDX.value)
        try requireHolder(inputs)
        let allTargets = context.xcodeProject.targets
        if !selectedTargets.isEmpty {
            let availableNames = Set(allTargets.map(\.displayName))
            let missing = selectedTargets.filter { !availableNames.contains($0) }
            guard missing.isEmpty else {
                let available = allTargets.map(\.displayName).sorted().joined(separator: "、")
                Diagnostics.error("找不到指定的 target：\(missing.joined(separator: "、"))。可用 target：\(available)")
                return
            }
        }
        let targets = selectedTargets.isEmpty
            ? allTargets
            : allTargets.filter { selectedTargets.contains($0.displayName) }
        for target in targets {
            let swiftFiles = target.inputFiles
                .filter { $0.path.extension == "swift" }
                .map { $0.path.string }
            guard !swiftFiles.isEmpty else { continue }
            let injected: [String] = [
                "--disable", "all",
                "--swiftversion", "6.2"
            ] + FormatRule.allToCommand + headerArguments(targetName: target.displayName, inputs: inputs)
            try runSwiftFormat(
                executable: tool.path,
                paths: swiftFiles,
                arguments: injected + remaining
            )
        }
    }
}
#endif
