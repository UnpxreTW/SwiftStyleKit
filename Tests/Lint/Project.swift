import ProjectDescription

let project = Project(
    name: "Lint",
    packages: [
        .local(path: "../..")
    ],
    targets: [
        .target(
            name: "Passing",
            destinations: [.mac],
            product: .framework,
            bundleId: "dev.unpxre.swiftstylekit.fixture.passing",
            deploymentTargets: .macOS("13.0"),
            sources: ["Sources/Passing.swift"],
            dependencies: [
                .package(product: "SwiftStyleLint", type: .plugin)
            ]
        ),
        .target(
            name: "Warning",
            destinations: [.mac],
            product: .framework,
            bundleId: "dev.unpxre.swiftstylekit.fixture.warning",
            deploymentTargets: .macOS("13.0"),
            sources: ["Sources/Warning.swift"],
            dependencies: [
                .package(product: "SwiftStyleLint", type: .plugin)
            ]
        ),
        .target(
            name: "Failing",
            destinations: [.mac],
            product: .framework,
            bundleId: "dev.unpxre.swiftstylekit.fixture.failing",
            deploymentTargets: .macOS("13.0"),
            sources: ["Sources/Failing.swift"],
            dependencies: [
                .package(product: "SwiftStyleLint", type: .plugin)
            ]
        )
    ]
)
