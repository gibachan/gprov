// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "gprov",
    platforms: [
        .macOS(.v11)
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            .upToNextMinor(from: "1.2.2")
        ),
    ],
    targets: [
        .executableTarget(
            name: "gprov",
            dependencies: [
                "GprovKit",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .target(
            name: "GprovKit",
            dependencies: []
        ),
        .testTarget(
            name: "GprovKitTests",
            dependencies: ["GprovKit"]
        ),
    ]
)
