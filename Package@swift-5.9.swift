// swift-tools-version:5.9
// swiftformat:disable all
import PackageDescription

let package = Package(
    name: "FoundationKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .macCatalyst(.v13),
        .visionOS(.v1),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "FoundationKit", targets: ["FoundationKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/NikSativa/SpryKit.git", .upToNextMajor(from: "3.0.0"))
    ],
    targets: [
        .target(name: "FoundationKit",
                dependencies: [
                ],
                path: "Source",
                resources: [
                    .process("PrivacyInfo.xcprivacy")
                ]),
        .testTarget(name: "FoundationKitTests",
                    dependencies: [
                        "FoundationKit",
                        "SpryKit",
                    ],
                    path: "Tests",
                    resources: [
                        .process("TestAssets.xcassets")
                    ])
    ]
)
