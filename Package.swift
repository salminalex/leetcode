// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LeetCode",
  products: [
    .library(
      name: "DataStructuresAndAlgorithms",
      targets: ["DataStructuresAndAlgorithms"]
    ),
  ],
  targets: [
    .target(
      name: "Solution",
      path: "Solution"
    ),
      .target(
        name: "DataStructuresAndAlgorithms",
        dependencies: ["Solution"],
        path: "DataStructuresAndAlgorithms"
      ),
    .testTarget(
      name: "DataStructuresAndAlgorithmsTests",
      dependencies: ["DataStructuresAndAlgorithms"],
      path: "DataStructuresAndAlgorithmsTests"
    ),
  ]
)
