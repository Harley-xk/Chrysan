// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Chrysan",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(name: "Chrysan", targets: ["Chrysan"]),
    ],
    dependencies: [
        // A Swift Autolayout DSL for iOS & OS X
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(name: "Chrysan", dependencies: ["SnapKit"], path: "Chrysan/Sources"),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
