// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Themes",
    platforms: [.iOS(.v10)],
    products: [.library(name: "Themes", targets: ["Themes"])],
    dependencies: [],
    targets: [.target(name: "Themes")]
)
