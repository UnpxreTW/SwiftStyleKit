import Foundation
import PackagePlugin

@main
struct SwiftStyleFormat: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) throws {
        var extractor = ArgumentExtractor(arguments)
        let selectedTargets = extractor.extractOption(named: "target")
        let holderOverride = extractor.extractOption(named: "copyright-holder")
        let remaining = extractor.remainingArguments

        let targets: [Target]
        if selectedTargets.isEmpty {
            targets = context.package.targets
        } else {
            targets = try context.package.targets(named: selectedTargets)
        }

        let tool = try context.tool(named: "swiftformat")
        let directory = context.package.directory
        let ctx = licenseInfo(directory: directory)
        let holders = resolveHolders(
            override: holderOverride,
            authors: readAuthors(directory: directory),
            licenseHolder: ctx.holder
        )
        for target in targets {
            guard let module = target as? SourceModuleTarget else { continue }
            let injected: [String] = [
                "--disable", "all",
                "--swiftversion", "6.2",
                "--symlinks", "follow"
            ] + FormatRule.allToCommand + headerArguments(targetName: module.name, holders: holders, license: ctx.license)
            try runSwiftFormat(
                executable: tool.path,
                paths: [module.directory.string],
                arguments: injected + remaining
            )
        }
    }

    /// 找專案根目錄的 `LICENSE`，解析版權持有人（fallback 用）與 ``FileHeaderBuilder/LicenseInfo``
    private func licenseInfo(directory: Path) -> (holder: String?, license: FileHeaderBuilder.LicenseInfo) {
        for name in ["LICENSE", "LICENSE.md", "LICENSE.txt"] {
            let url = URL(fileURLWithPath: directory.string + "/" + name)
            guard let text = try? String(contentsOf: url, encoding: .utf8) else { continue }
            let holder = FileHeaderBuilder.copyrightHolder(in: text)
            if let license = FileHeaderBuilder.recognizeLicense(in: text) {
                return (holder, .recognized(name: license.name, spdxID: license.spdxID))
            }
            return (holder, .unrecognized)
        }
        return (nil, .missing)
    }

    /// 找專案根目錄的 `AUTHORS` 並抓出版權持有人清單（每行非空非註解一筆）
    private func readAuthors(directory: Path) -> [String] {
        for name in ["AUTHORS", "AUTHORS.md", "AUTHORS.txt"] {
            let url = URL(fileURLWithPath: directory.string + "/" + name)
            guard let text = try? String(contentsOf: url, encoding: .utf8) else { continue }
            return FileHeaderBuilder.authors(in: text)
        }
        return []
    }

    /// 版權持有人來源優先序：`--copyright-holder` flag > `AUTHORS` > `LICENSE` 解析 > 無
    private func resolveHolders(override: [String], authors: [String], licenseHolder: String?) -> [String] {
        if !override.isEmpty { return override }
        if !authors.isEmpty { return authors }
        if let licenseHolder { return [licenseHolder] }
        return []
    }

    /// 為單一 target 組出 `fileHeader` 規則的 CLI 參數
    private func headerArguments(targetName: String, holders: [String], license: FileHeaderBuilder.LicenseInfo) -> [String] {
        let header = FileHeaderBuilder.header(targetName: targetName, holders: holders, license: license)
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
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SwiftStyleFormat: XcodeCommandPlugin {
    func performCommand(context: XcodePluginContext, arguments: [String]) throws {
        var extractor = ArgumentExtractor(arguments)
        let selectedTargets = extractor.extractOption(named: "target")
        let holderOverride = extractor.extractOption(named: "copyright-holder")
        let remaining = extractor.remainingArguments

        let tool = try context.tool(named: "swiftformat")
        let directory = context.xcodeProject.directory
        let ctx = licenseInfo(directory: directory)
        let holders = resolveHolders(
            override: holderOverride,
            authors: readAuthors(directory: directory),
            licenseHolder: ctx.holder
        )
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
            ] + FormatRule.allToCommand + headerArguments(targetName: target.displayName, holders: holders, license: ctx.license)
            try runSwiftFormat(
                executable: tool.path,
                paths: swiftFiles,
                arguments: injected + remaining
            )
        }
    }
}
#endif
