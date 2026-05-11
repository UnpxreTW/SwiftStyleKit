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
            try runSwiftFormat(
                executable: tool.path,
                directory: module.directory,
                arguments: remaining
            )
        }
    }

    private func runSwiftFormat(executable: Path, directory: Path, arguments: [String]) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: executable.string)
        process.arguments = [directory.string] + arguments
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
        try runSwiftFormat(
            executable: tool.path,
            directory: context.xcodeProject.directory,
            arguments: ["--disable", "all"] + arguments
        )
    }
}
#endif
