// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swia",
    platforms: [
        .macOS(.v11),
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Swia",
            targets: ["Swia"])
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "cskia",
            path: "Frameworks/cskia.xcframework"),
        .target(
            name: "CSkia",
            dependencies: [.byName(name: "cskia")]),
        .target(
            name: "Swia",
            dependencies: ["CSkia"],
            linkerSettings: [
                .linkedLibrary("c++")
            ]),
        .executableTarget(
            name: "Demo",
            dependencies: ["Swia"])
    ],
    cxxLanguageStandard: .cxx17
)
