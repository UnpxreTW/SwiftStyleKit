import ProjectDescription

let project = Project(
    name: "Failing",
    packages: [
        .local(path: "../../..")
    ],
    targets: [
        .target(
            name: "Failing",
            destinations: [.mac],
            product: .framework,
            bundleId: "dev.unpxre.swiftstylekit.fixture.failing",
            sources: ["Sources/Failing/**"],
            dependencies: [
                .package(product: "SwiftStyleLint", type: .plugin)
            ]
        )
    ]
)
