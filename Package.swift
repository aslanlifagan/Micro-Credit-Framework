// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MicroCreditSDK",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MicroCreditSDK",
            targets: ["MicroCreditSDK"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(name: "MicroCreditSDK", path: "./bin/MicroCreditSDK.xcframework"),
    ]
)
