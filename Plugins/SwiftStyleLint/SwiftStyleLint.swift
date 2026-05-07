import Foundation
import PackagePlugin

@main
struct SwiftStyleLint: BuildToolPlugin {
    func createBuildCommands(
        context: PluginContext, target: Target
    ) throws -> [Command] {
        guard let target = target as? SourceModuleTarget else { return [] }
        return try makeCommand(
            executable: context.tool(named: "swiftlint").path,
            swiftFiles: target.sourceFiles(withSuffix: "swift").map(\.path),
            workDirectory: context.package.directory,
            pluginWorkDirectory: context.pluginWorkDirectory
        )
    }

    private func makeCommand(
        executable: Path, swiftFiles: [Path],
        workDirectory: Path, pluginWorkDirectory: Path
    ) throws -> [Command] {
        let outputDir = pluginWorkDirectory.appending("Output")
        let cacheDir = pluginWorkDirectory.appending("Cache")
        let arguments: [String] = [
            "lint", "--quiet", "--force-exclude",
            "--cache-path", cacheDir.string
        ] + swiftFiles.map(\.string)
        return [
            .prebuildCommand(
                displayName: "SwiftStyleLint",
                executable: executable,
                arguments: arguments,
                environment: ["BUILD_WORKSPACE_DIRECTORY": workDirectory.string],
                outputFilesDirectory: outputDir
            )
        ]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SwiftStyleLint: XcodeBuildToolPlugin {
    func createBuildCommands(
        context: XcodePluginContext, target: XcodeTarget
    ) throws -> [Command] {
        try makeCommand(
            executable: context.tool(named: "swiftlint").path,
            swiftFiles: target.inputFiles
                .filter { $0.path.extension == "swift" }
                .map(\.path),
            workDirectory: context.xcodeProject.directory,
            pluginWorkDirectory: context.pluginWorkDirectory
        )
    }
}
#endif
