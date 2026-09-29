// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-list-linked",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "List Linked",
            targets: ["List Linked"]
        ),
        .library(
            name: "List Linked Primitive",
            targets: ["List Linked Primitive"]
        ),
        .library(
            name: "List Linked Test Support",
            targets: ["List Linked Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-list.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-buffer.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-buffer-linked.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-iterator.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-sequence.git",
            branch: "main"
        ),

        .package(
            url: "https://github.com/swift-atoms/swift-storage.git",
            branch: "main", traits: ["Generational"]),
        .package(
            url: "https://github.com/swift-atoms/swift-memory.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "List Linked Primitive",
            dependencies: [
                .product(name: "List", package: "swift-list"),
                .product(name: "Index", package: "swift-index"),
                .product(
                    name: "Buffer Linked Primitive",
                    package: "swift-buffer-linked"
                ),
                .product(
                    name: "Buffer Linked",
                    package: "swift-buffer-linked"
                ),
                .product(name: "Iterator", package: "swift-iterator"),
                .product(name: "Storage", package: "swift-storage"),
                .product(name: "Memory", package: "swift-memory"),
            ]
        ),

        .target(
            name: "List Linked",
            dependencies: [
                "List Linked Primitive",
                .product(name: "List", package: "swift-list"),
                .product(name: "Index", package: "swift-index"),
                .product(
                    name: "Buffer Linked Primitive",
                    package: "swift-buffer-linked"
                ),
                .product(
                    name: "Buffer Linked",
                    package: "swift-buffer-linked"
                ),
                .product(name: "Iterator", package: "swift-iterator"),
                .product(name: "Sequence", package: "swift-sequence"),
                .product(name: "Property", package: "swift-property"),
            ]
        ),

        .target(
            name: "List Linked Test Support",
            dependencies: [
                "List Linked",
                .product(
                    name: "Buffer Test Support",
                    package: "swift-buffer"
                ),
                .product(name: "Index Test Support", package: "swift-index"),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "List Linked Tests",
            dependencies: [
                "List Linked",
                "List Linked Test Support",
                .product(name: "Iterator", package: "swift-iterator"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = [
        .enableExperimentalFeature("RawLayout")
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
