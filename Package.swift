// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DopplerExtendedAttributes",
    products: [
        .library(
            name: "DopplerExtendedAttributes",
            targets: ["DopplerExtendedAttributes"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/brushedtype/swift-xattr", from: "0.3.0"),
    ],
    targets: [
        .target(
            name: "DopplerExtendedAttributes",
            dependencies: [
                .product(name: "ExtendedAttributes", package: "swift-xattr"),
            ]
        ),
    ]
)
