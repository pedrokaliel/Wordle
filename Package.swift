// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "wordle-pt",
    products: [
        .library(name: "WordleCore", targets: ["WordleCore"]),
        .executable(name: "wordle", targets: ["WordleCLI"])
    ],
    targets: [
        .target(name: "WordleCore"),
        .executableTarget(name: "WordleCLI", dependencies: ["WordleCore"]),
        .testTarget(name: "WordleCoreTests", dependencies: ["WordleCore"])
    ]
)