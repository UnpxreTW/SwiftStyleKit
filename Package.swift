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
            url: "https://github.com/realm/SwiftLint/releases/download/0.63.2/SwiftLintBinary.artifactbundle.zip",
            checksum: "12befab676fc972ffde2ec295d016d53c3a85f64aabd9c7fee0032d681e307e9"
        ),
        .binaryTarget(
            name: "SwiftFormatBinary",
            url: "https://github.com/nicklockwood/SwiftFormat/releases/download/0.61.1/swiftformat.artifactbundle.zip",
            checksum: "47f7932f35c714b00430f56df1cfaf1bea0b4baae299bb2a09874cb52ee45350"
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
