// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReduxStore",
    platforms: [
            .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ReduxStore",
            targets: ["ReduxStore"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ReduxStore"),
        .testTarget(
            name: "ReduxStoreTests",
            dependencies: ["ReduxStore"]),
    ]
)
