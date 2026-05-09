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
            sources: ["Sources/Failing.swift"],
            dependencies: [
                .package(product: "SwiftStyleLint", type: .plugin)
            ]
        )
    ]
)
