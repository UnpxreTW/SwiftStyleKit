// swift-tools-version: 6.3
// FormatRuleCodegen — FormatRule 型別安全 overload 生成工具（dev-time、一次性）
//
// 讀真實 FormatRule.swift -> 解析每個 enum case -> 分類形狀 -> 生成型別安全的
// enable/disable/diagnostic overloads（`FormatRule+SafeOverloads.swift`）並就地把 storage
// enum 的 case 名加 `_` 前綴（含 `fileHeader` 合成 String 預設）。
//
// 反 SwiftSyntax 傳染：swift-syntax 依賴**只**宣告在此獨立 package。主 Package.swift
// 維持零 source 依賴；生成的 overload 是純 Swift 檔、commit 進庫、消費者看不到 SwiftSyntax。
import PackageDescription

let package = Package(
    name: "FormatRuleCodegen",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "603.0.0")
    ],
    targets: [
        .executableTarget(
            name: "FormatRuleCodegen",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax")
            ]
        )
    ]
)
