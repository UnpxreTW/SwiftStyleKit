// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftStyleKit",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .plugin(
            name: "SwiftStyleLint",
            targets: ["SwiftStyleLint"]
        ),
        .plugin(
            name: "SwiftStyleFormat",
            targets: ["SwiftStyleFormat"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.63.3/SwiftLintBinary.artifactbundle.zip",
            checksum: "a0a59ee28019171fb43a4278ae2f7eac610e194b4d98abf47fd6092c7aff65aa"
        ),
        .binaryTarget(
            name: "SwiftFormatBinary",
            url: "https://github.com/nicklockwood/SwiftFormat/releases/download/0.61.1/swiftformat.artifactbundle.zip",
            checksum: "a0a59ee28019171fb43a4278ae2f7eac610e194b4d98abf47fd6092c7aff65aa"
        ),
        .plugin(
            name: "SwiftStyleLint",
            capability: .buildTool(),
            dependencies: [
                .target(name: "SwiftLintBinary"),
            ]
        ),
        .plugin(
            name: "SwiftStyleFormat",
            capability: .command(
                intent: .sourceCodeFormatting(),
                permissions: [.writeToPackageDirectory(reason: "格式化原始碼")]
            ),
            dependencies: [
                .target(name: "SwiftFormatBinary"),
            ]
        ),
        .target(
            name: "SwiftStyleFormatCore",
            path: "Sources/SwiftStyleFormatCore",
            plugins: [.plugin(name: "SwiftStyleLint")]
        ),
        .testTarget(
            name: "FormatRuleTests",
            dependencies: ["SwiftStyleFormatCore"],
            path: "Tests/FormatRuleTests",
            plugins: [.plugin(name: "SwiftStyleLint")]
        ),
    ]
)
