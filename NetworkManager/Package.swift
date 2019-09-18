// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkManager",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "NetworkManager",
            targets: ["NetworkManager"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift.git", from: "6.0.0"),
        .package(url: "https://github.com/NPasini/OSLogger.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "NetworkManager",
            dependencies: ["ReactiveSwift", "OSLogger"]),
        .testTarget(
            name: "NetworkManagerTests",
            dependencies: ["NetworkManager"]),
    ]
)
