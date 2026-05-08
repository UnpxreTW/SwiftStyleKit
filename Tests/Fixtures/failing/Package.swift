// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Failing",
    platforms: [.macOS(.v12)],
    dependencies: [.package(path: "../../..")],
    targets: [
        .target(
            name: "Failing",
            dependencies: [],
            plugins: [.plugin(name: "SwiftStyleLint", package: "SwiftStyleKit")]
        )
    ]
)
