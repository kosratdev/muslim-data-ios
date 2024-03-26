// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MuslimData",
    platforms: [
         .iOS(.v13),
         .macOS(.v12),
         .tvOS(.v13),
         .visionOS(.v1),
         .watchOS(.v6)
     ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MuslimData",
            targets: ["MuslimData"]),
    ],
    dependencies: [
        .package(url: "https://github.com/groue/GRDB.swift.git", exact: "6.26.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MuslimData",
            dependencies: [
                .product(name: "GRDB", package: "GRDB.swift")
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "MuslimDataTests",
            dependencies: ["MuslimData"]),
    ]
)
