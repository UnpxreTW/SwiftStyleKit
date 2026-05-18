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
        for target in targets {
            guard let module = target as? SourceModuleTarget else { continue }
            let injected: [String] = [
                "--disable", "all",
                "--swiftversion", "6.2",
                "--symlinks", "follow"
            ] + FormatRule.allToCommand(with: module.name)
            try runSwiftFormat(
                executable: tool.path,
                paths: [module.directory.string],
                arguments: injected + remaining
            )
        }
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
        for target in context.xcodeProject.targets {
            let swiftFiles = target.inputFiles
                .filter { $0.path.extension == "swift" }
                .map { $0.path.string }
            guard !swiftFiles.isEmpty else { continue }
            let injected: [String] = [
                "--disable", "all",
                "--swiftversion", "6.2"
            ] + FormatRule.allToCommand(with: target.displayName)
            try runSwiftFormat(
                executable: tool.path,
                paths: swiftFiles,
                arguments: injected + arguments
            )
        }
    }
}
#endif
