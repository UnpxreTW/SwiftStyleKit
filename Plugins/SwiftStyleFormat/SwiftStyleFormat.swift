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
        let license = readLicenseInfo(directory: context.package.directory)
        for target in targets {
            guard let module = target as? SourceModuleTarget else { continue }
            let injected: [String] = [
                "--disable", "all",
                "--swiftversion", "6.2",
                "--symlinks", "follow"
            ] + FormatRule.allToCommand + headerArguments(targetName: module.name, license: license)
            try runSwiftFormat(
                executable: tool.path,
                paths: [module.directory.string],
                arguments: injected + remaining
            )
        }
    }

    /// 找專案根目錄的 `LICENSE` 並解析成 ``FileHeaderBuilder/LicenseInfo``
    private func readLicenseInfo(directory: Path) -> FileHeaderBuilder.LicenseInfo {
        for name in ["LICENSE", "LICENSE.md", "LICENSE.txt"] {
            let url = URL(fileURLWithPath: directory.string + "/" + name)
            guard let text = try? String(contentsOf: url, encoding: .utf8) else { continue }
            let holder = FileHeaderBuilder.copyrightHolder(in: text)
            if let license = FileHeaderBuilder.recognizeLicense(in: text) {
                return .recognized(holder: holder, name: license.name, spdxID: license.spdxID)
            }
            return .unrecognized(holder: holder)
        }
        return .missing
    }

    /// 為單一 target 組出 `fileHeader` 規則的 CLI 參數
    private func headerArguments(targetName: String, license: FileHeaderBuilder.LicenseInfo) -> [String] {
        let header = FileHeaderBuilder.header(targetName: targetName, license: license)
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
        let tool = try context.tool(named: "swiftformat")
        let license = readLicenseInfo(directory: context.xcodeProject.directory)
        for target in context.xcodeProject.targets {
            let swiftFiles = target.inputFiles
                .filter { $0.path.extension == "swift" }
                .map { $0.path.string }
            guard !swiftFiles.isEmpty else { continue }
            let injected: [String] = [
                "--disable", "all",
                "--swiftversion", "6.2"
            ] + FormatRule.allToCommand + headerArguments(targetName: target.displayName, license: license)
            try runSwiftFormat(
                executable: tool.path,
                paths: swiftFiles,
                arguments: injected + arguments
            )
        }
    }
}
#endif
