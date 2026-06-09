import Foundation
import PackagePlugin

@main
struct SwiftStyleFormat: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) throws {
        var extractor = ArgumentExtractor(arguments)
        let selectedTargets = extractor.extractOption(named: "target")
        let remaining = extractor.remainingArguments

        let targets: [Target]
        if selectedTargets.isEmpty {
            targets = context.package.targets
        } else {
            targets = try context.package.targets(named: selectedTargets)
        }

        let tool = try context.tool(named: "swiftformat")
        let inputs = headerInputs(directory: context.package.directory)
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
    private func headerInputs(directory: Path) -> HeaderInputs {
        let (license, licenseHolder) = licenseInfo(directory: directory)
        return HeaderInputs(
            license: license,
            licenseHolder: licenseHolder,
            noticeHolder: noticeHolder(directory: directory),
            authors: readAuthors(directory: directory)
        )
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
            Diagnostics.error("swiftformat 失敗 (exit \(process.terminationStatus))")
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
        let remaining = extractor.remainingArguments

        let tool = try context.tool(named: "swiftformat")
        let inputs = headerInputs(directory: context.xcodeProject.directory)
        let targets = selectedTargets.isEmpty
            ? context.xcodeProject.targets
            : context.xcodeProject.targets.filter { selectedTargets.contains($0.displayName) }
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
