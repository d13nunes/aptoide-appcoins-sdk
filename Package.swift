// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorAppcoinsSdk",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "CapacitorAppcoinsSdk",
            targets: ["AppCoinsSdkPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "7.0.0"),
        .package(url: "https://github.com/Catappult/appcoins-sdk-ios.git", from: "1.5.0")
    ],
    targets: [
        .target(
            name: "AppCoinsSdkPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm"),
                .product(name: "AppCoinsSDK", package: "appcoins-sdk-ios")
            ],
            path: "ios/Sources/AppCoinsSdkPlugin"),
        .testTarget(
            name: "AppCoinsSdkPluginTests",
            dependencies: ["AppCoinsSdkPlugin"],
            path: "ios/Tests/AppCoinsSdkPluginTests")
    ]
)
