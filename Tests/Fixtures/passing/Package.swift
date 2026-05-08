// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Passing",
    platforms: [.macOS(.v12)],
    dependencies: [.package(path: "../../..")],
    targets: [
        .target(
            name: "Passing",
            dependencies: [],
            plugins: [.plugin(name: "SwiftStyleLint", package: "SwiftStyleKit")]
        )
    ]
)
