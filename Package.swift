// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftStyleKit",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "SwiftStyleKit",
            targets: ["SwiftStyleKit"]
        ),
        .plugin(
            name: "SwiftStyleLint",
            targets: ["SwiftStyleLint"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftStyleKit",
            plugins: [
                .plugin(name: "SwiftStyleLint"),
            ]
        ),
        .binaryTarget(
            name: "SwiftLintBinary",
            url: "https://github.com/realm/SwiftLint/releases/download/0.63.2/SwiftLintBinary.artifactbundle.zip",
            checksum: "12befab676fc972ffde2ec295d016d53c3a85f64aabd9c7fee0032d681e307e9"
        ),
        .plugin(
            name: "SwiftStyleLint",
            capability: .buildTool(),
            dependencies: [
                .target(name: "SwiftLintBinary"),
            ]
        ),
    ]
)
