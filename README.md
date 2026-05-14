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

## SwiftStyleLint：strict 模式（環境變數開關）

`SwiftStyleLint` plugin 預設不帶 `--strict`、warning-severity violation 只印 stdout 不 fail build。要把 warning 升 error 直接 fail build、export 環境變數 `SWIFTSTYLELINT_STRICT=1`：

```bash
SWIFTSTYLELINT_STRICT=1 swift build
```

CI 設定範例（GitHub Actions）：

```yaml
jobs:
  test:
    runs-on: macos-latest
    env:
      SWIFTSTYLELINT_STRICT: '1'
    steps:
      - run: swift build
```

未設、或設為任何非 `1` 的值時、走 default non-strict 行為。對下游既有 codebase 想漸進採用 SwiftStyleKit 的情境友好——先 attach plugin 看 warning 清單、整理完了再設 `SWIFTSTYLELINT_STRICT=1` 鎖死。

## 開發

本機開發 SwiftStyleKit 本身時、export 環境變數讓 dogfooding lint 行為跟 CI 一致：

```bash
export SWIFTSTYLELINT_STRICT=1
```

CI workflow 已設 job-level `SWIFTSTYLELINT_STRICT: '1'`、本機 export 後 `swift build` / `swift test` 跟 CI 同樣 strict、不會發生「本機 pass、push 上 CI 才 strict fail」的 round-trip。

可寫進 shell profile（`~/.zshrc` / `~/.bashrc`）永久、或進 SwiftStyleKit 工作目錄前手動 export。
