// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModalSwiftUI",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "ModalSwiftUI",
            targets: ["ModalSwiftUI"]),
    ],
    targets: [
        .target(
            name: "ModalSwiftUI", path: "Sources"),
    ]
)
