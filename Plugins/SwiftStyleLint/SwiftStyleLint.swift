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
        var arguments: [String] = [
            "lint", "--quiet", "--force-exclude",
            "--cache-path", cacheDir.string
        ]
        // 環境變數 SWIFTSTYLELINT_STRICT=1 時 lint 走 --strict、任何 warning 升 error
        if ProcessInfo.processInfo.environment["SWIFTSTYLELINT_STRICT"] == "1" {
            arguments.append("--strict")
        }
        arguments.append(contentsOf: swiftFiles.map(\.string))
        // Xcode 的 XcodeBuildToolPlugin 路徑不會自動建立 outputFilesDirectory，
        // build system 在 prebuild command 結束後要掃描該目錄收集輸出、缺目錄會中止建置。
        // （Cache 由 swiftlint --cache-path 寫入時自行建立、不需預建。）
        try FileManager.default.createDirectory(
            atPath: outputDir.string, withIntermediateDirectories: true
        )
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
