// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftStyleKit",
    platforms: [
        .macOS(.v13),
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
            url: "https://github.com/realm/SwiftLint/releases/download/0.65.1/SwiftLintBinary.artifactbundle.zip",
            checksum: "c3a1d77647ca18c1b7e9be7dbc6cd4490d26422f28814b76370244ff61970869"
        ),
        .binaryTarget(
            name: "SwiftFormatBinary",
            url: "https://github.com/nicklockwood/SwiftFormat/releases/download/0.62.1/swiftformat.artifactbundle.zip",
            checksum: "6595f3121e657438a24dabd9f8fecb648d3f362e5106df0968f734f5863fe404"
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
