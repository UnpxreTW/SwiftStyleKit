import Foundation
import PackagePlugin

@main
struct SwiftStyleLint: BuildToolPlugin {
    func createBuildCommands(
        context: PluginContext, target: Target
    ) throws -> [Command] {
        guard let target = target as? SourceModuleTarget else { return [] }
        return try makeCommand(
            executable: context.tool(named: "swiftlint").url,
            swiftFiles: target.sourceFiles(withSuffix: "swift").map(\.url),
            workDirectory: context.package.directoryURL,
            pluginWorkDirectory: context.pluginWorkDirectoryURL
        )
    }

    private func makeCommand(
        executable: URL, swiftFiles: [URL],
        workDirectory: URL, pluginWorkDirectory: URL
    ) throws -> [Command] {
        let outputDir = pluginWorkDirectory.appendingPathComponent("Output")
        let cacheDir = pluginWorkDirectory.appendingPathComponent("Cache")
        let arguments: [String] = [
            "lint", "--quiet", "--force-exclude",
            "--cache-path", cacheDir.path,
        ] + swiftFiles.map(\.path)
        return [
            .prebuildCommand(
                displayName: "SwiftStyleLint",
                executable: executable,
                arguments: arguments,
                environment: ["BUILD_WORKSPACE_DIRECTORY": workDirectory.path],
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
            executable: context.tool(named: "swiftlint").url,
            swiftFiles: target.inputFiles
                .filter { $0.url.pathExtension == "swift" }
                .map(\.url),
            workDirectory: context.xcodeProject.directoryURL,
            pluginWorkDirectory: context.pluginWorkDirectoryURL
        )
    }
}
#endif
