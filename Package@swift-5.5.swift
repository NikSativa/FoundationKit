// swift-tools-version:5.5
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "FoundationKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "FoundationKit", targets: ["FoundationKit"]),
        .library(name: "FoundationKitTestHelpers", targets: ["FoundationKitTestHelpers"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMajor(from: "2.2.0")),
    ],
    targets: [
        .target(name: "FoundationKit",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .target(name: "FoundationKitTestHelpers",
                dependencies: [
                    "FoundationKit",
                    "SpryKit"
                ],
                path: "TestHelpers",
                resources: [
                    .copy("../PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "FoundationKitTests",
                    dependencies: [
                        "FoundationKit",
                        "FoundationKitTestHelpers",
                        "SpryKit",
                    ],
                    path: "Tests")
    ]
)
