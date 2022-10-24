// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CLINotes",
    products: [
        .executable(
            name: "CLINotes",
            targets: ["CLINotes"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "CLINotes",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]),
    ]
)
