// swift-tools-version: 5.9
import PackageDescription
import Foundation

let allTargets: [Target] = [
    .target(
        name: "Passing",
        path: "Sources",
        exclude: ["Warning.swift", "Failing.swift"],
        plugins: [.plugin(name: "SwiftStyleLint", package: "SwiftStyleKit")]
    ),
    .target(
        name: "Warning",
        path: "Sources",
        exclude: ["Passing.swift", "Failing.swift"],
        plugins: [.plugin(name: "SwiftStyleLint", package: "SwiftStyleKit")]
    ),
    .target(
        name: "Failing",
        path: "Sources",
        exclude: ["Passing.swift", "Warning.swift"],
        plugins: [.plugin(name: "SwiftStyleLint", package: "SwiftStyleKit")]
    )
]

let only = ProcessInfo.processInfo.environment["LINT_TARGET"]
let targets: [Target] = only.flatMap { name in
    allTargets.first(where: { $0.name == name }).map { [$0] }
} ?? allTargets

let package = Package(
    name: "Lint",
    platforms: [.macOS(.v12)],
    dependencies: [.package(path: "../..")],
    targets: targets
)
