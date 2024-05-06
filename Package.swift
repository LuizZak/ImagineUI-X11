// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "ImagineUI-X11",
    products: [
        .library(
            name: "ImagineUI-X11",
            targets: ["ImagineUI-X11"]
        ),
        .executable(
            name: "ImagineUI-X11_Sample",
            targets: ["ImagineUI-X11_Sample"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/LuizZak/ImagineUI.git", branch: "master"),
        .package(url: "https://github.com/apple/swift-log.git", branch: "main"),
    ],
    targets: [
        .systemLibrary(name: "CX11"),
        .target(
            name: "MinX11",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                "CX11",
            ]
        ),
        .target(
            name: "ImagineUI-X11",
            dependencies: [
                .product(name: "ImagineUI", package: "ImagineUI"),
                .product(name: "Blend2DRenderer", package: "ImagineUI"),
                "MinX11",
            ]
        ),
        .executableTarget(
            name: "ImagineUI-X11_Sample",
            dependencies: ["ImagineUI-X11"]
        ),
        .testTarget(
            name: "ImagineUI-X11Tests",
            dependencies: ["ImagineUI-X11"]
        ),
    ]
)
