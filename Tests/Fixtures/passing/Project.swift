import ProjectDescription

let project = Project(
    name: "Passing",
    packages: [
        .local(path: "../../..")
    ],
    targets: [
        .target(
            name: "Passing",
            destinations: [.mac],
            product: .framework,
            bundleId: "dev.unpxre.swiftstylekit.fixture.passing",
            sources: ["Sources/Passing/**"],
            dependencies: [
                .package(product: "SwiftStyleLint", type: .plugin)
            ]
        )
    ]
)
