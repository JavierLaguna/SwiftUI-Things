// swift-tools-version: 6.0
import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "iOS26Macros",
    platforms: [.iOS(.v18), .macOS(.v10_15)],
    products: [
        .library(
            name: "iOS26Macros",
            targets: ["iOS26Macros"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "600.0.0"),
    ],
    targets: [
        .macro(
            name: "iOS26MacrosMacros",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        .target(
            name: "iOS26Macros",
            dependencies: ["iOS26MacrosMacros"]
        ),
        .testTarget(
            name: "iOS26MacrosTests",
            dependencies: [
                "iOS26MacrosMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ],
            path: "Tests/iOS26MacrosTests"
        ),
    ]
)
