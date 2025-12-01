// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "GTVSdkIos",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Product: Core version
        .library(
            name: "GTVSdkIosCore",
            targets: ["GTVSdkIosCoreWrapper"]
        ),

        // Product: Full version
        .library(
            name: "GTVSdkIosFull",
            targets: ["GTVSdkIosFullWrapper"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            from: "12.3.0"
        ),
        .package(
            url: "https://github.com/ab180/airbridge-ios-sdk-deployment",
            from: "4.8.1"
        ),
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git",
            from: "12.11.0"
        ),
    ],
    targets: [

        // MARK: - Core Binary (module name vẫn là GTVSdkIos)
        .binaryTarget(
            name: "GTVSdkIosCoreBinary",
            path: "Core/GTVSdkIos.xcframework"
        ),

        // MARK: - Full Binary (module name cũng là GTVSdkIos)
        .binaryTarget(
            name: "GTVSdkIosFullBinary",
            path: "Full/GTVSdkIos.xcframework"
        ),

        // MARK: - Core Wrapper
        .target(
            name: "GTVSdkIosCoreWrapper",
            dependencies: [
                "GTVSdkIosCoreBinary",
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "Airbridge", package: "airbridge-ios-sdk-deployment"),
            ],
            path: "Sources/GTVSdkIosCoreWrapper"
        ),

        // MARK: - Full Wrapper
        .target(
            name: "GTVSdkIosFullWrapper",
            dependencies: [
                "GTVSdkIosFullBinary",
                .product(name: "FirebaseMessaging", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "Airbridge", package: "airbridge-ios-sdk-deployment"),
                .product(name: "GoogleMobileAds", package: "swift-package-manager-google-mobile-ads"),
            ],
            path: "Sources/GTVSdkIosFullWrapper"
        ),
    ]
)
