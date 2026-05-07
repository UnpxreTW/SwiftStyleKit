# SwiftStyleKit

把 SwiftLint + SwiftFormat 與規則設定打包成 Swift Package；下游 `.package(...)` 即用、無需在 repo root 放 `.swiftlint.yml` 或 `.swiftformat`。

## Dependencies

### SwiftLintBinary（直接 binaryTarget）

`Package.swift` 用 SwiftPM `.binaryTarget` 直接掛載 [realm/SwiftLint](https://github.com/realm/SwiftLint) 官方發布的 `SwiftLintBinary.artifactbundle.zip`：

```swift
.binaryTarget(
    name: "SwiftLintBinary",
    url: "https://github.com/realm/SwiftLint/releases/download/<VERSION>/SwiftLintBinary.artifactbundle.zip",
    checksum: "<SHA-256>"
)
```

`SwiftStyleLint` plugin 透過 `context.tool(named: "swiftlint")` 解析到 artifact bundle 內的 binary、不需要下游額外裝 SwiftLint。下游 SwiftPM resolve 時會把 binary 解壓到 `.build/artifacts/swiftstylekit/SwiftLintBinary/SwiftLintBinary.artifactbundle/macos/swiftlint`（macOS）或對應 Linux 路徑。

### SwiftLint 跟版自動化

Dependabot **不追 `.binaryTarget` 的 URL**——是 GitHub 設計如此。所以使用 GitHub Actions cron workflow 補：

`.github/workflows/swiftlint-version-check.yml`：

- 每週一 09:00 Asia/Taipei（cron `0 1 * * 1` UTC）+ `workflow_dispatch` 手動觸發
- 抓 `realm/SwiftLint` latest release tag、跟 `Package.swift` 內版號比對
- 不同就：下載新 artifactbundle → `swift package compute-checksum` 算新 checksum → `sed` 改 `Package.swift` URL + checksum → 開 PR `build(deps): bump SwiftLint from <OLD> to <NEW>`

PR 形式跟 Dependabot 一致、複用同一套 review mental model。

### SwiftLintPlugins

`Package.swift` `dependencies` 區段掛 [SimplyDanny/SwiftLintPlugins](https://github.com/SimplyDanny/SwiftLintPlugins)，但**目前沒有 target 引用它**——SwiftStyleLint plugin 走的是上面自宣告的 `.binaryTarget`、不是經 SwiftLintPlugins 的 `SwiftLintBinary` product。掛在 dependencies 區是 SwiftPM 規劃保留位、未來若有需要可移除或改為實際引用。
