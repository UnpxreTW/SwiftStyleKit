# SwiftStyleKit

把 SwiftLint + SwiftFormat 與規則設定打包成 Swift Package；下游 `.package(...)` 即用、無需在 repo root 放 `.swiftlint.yml` 或 `.swiftformat`。

## 安裝

```swift
.package(url: "https://github.com/UnpxreTW/SwiftStyleKit.git", from: "2.0.1")
```

下游 target 掛 `SwiftStyleLint`（build tool plugin）與／或 `SwiftStyleFormat`（command plugin）即可套用規則，細節見下方各節。

## 相依套件

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

## SwiftStyleFormat：檔頭授權覆寫（`--header-spdx`）

檔頭的授權行預設由專案根目錄 `LICENSE` 自動辨識。辨識不到（罕見授權、自訂條款）或要強制指定時，傳 `--header-spdx` 直接給定單一 SPDX 授權識別字、跳過自動辨識：

```bash
swift package plugin --allow-writing-to-package-directory format-source-code --header-spdx FSL-1.1-ALv2
```

- 接受 SPDX License List 的 idstring 與 REUSE 規範的 `LicenseRef-<idstring>` 自訂授權（如 `--header-spdx LicenseRef-MyTerms`，搭配 `LICENSES/LicenseRef-MyTerms.txt`）。
- 不接受 `AND` / `OR` / `WITH` 複合運算式——檔頭一檔一授權、複合情境改以 `REUSE.toml` 表達。
- 版權持有人來源檔（`LICENSE` / `NOTICE` / `AUTHORS`）照常解析、不受覆寫影響。

## 開發

### 本機 dogfooding（strict 模式）

本機開發 SwiftStyleKit 本身時、export 環境變數讓 dogfooding lint 行為跟 CI 一致：

```bash
export SWIFTSTYLELINT_STRICT=1
```

CI workflow 已設 job-level `SWIFTSTYLELINT_STRICT: '1'`、本機 export 後 `swift build` / `swift test` 跟 CI 同樣 strict、不會發生「本機 pass、push 上 CI 才 strict fail」的 round-trip。

可寫進 shell profile（`~/.zshrc` / `~/.bashrc`）永久、或進 SwiftStyleKit 工作目錄前手動 export。

### 新增 / 修改格式規則

每條 swiftformat 規則對應 `FormatRule` enum 的一個 case。為了讓 `.disable + option` 這種無效組合在編譯期就被擋下（而非 runtime 默默忽略），規則的 public API 是一組型別安全 overload，由 `Tools/FormatRuleCodegen` 從 `FormatRule.swift` 自動生成。

#### 為什麼是 codegen，不是 macro

型別安全靠 `EnableToken` / `DisableToken` 兩個型別把 `.enable` / `.disable` 分流到不同 overload。手寫這批 overload（每條規則 2–3 個、上百條）不現實；但若用 Swift macro 即時展開，會把 swift-syntax 依賴傳染給每一個下游、還可能跟對方的 macro 套件撞版本。所以改用 dev-time codegen：

- swift-syntax 只宣告在 `Tools/FormatRuleCodegen/Package.swift`，主 `Package.swift` 維持零 source 依賴。
- 產物 `FormatRule+SafeOverloads.swift` 是純 Swift、commit 進庫；下游只看到生成好的 overload，看不到 swift-syntax。

#### 操作：加 / 改一條規則

1. 在 `FormatRule.swift` 加 / 改 case，case 名 = swiftformat 規則名。第一個參數固定 `rule: Flag`、其後是該規則的 option（每個 option 都要給預設值，見下方規範）。
2. 重跑 codegen：

   ```bash
   swift run --package-path Tools/FormatRuleCodegen FormatRuleCodegen \
     Plugins/SwiftStyleFormat/FormatRule/FormatRule.swift \
     Plugins/SwiftStyleFormat/FormatRule
   ```

   codegen 會（a）就地把 storage case 名加 `_` 前綴、（b）生成 / 覆寫 `FormatRule+SafeOverloads.swift`，並在 stderr 印一份分類報告（各形狀數量、特例清單）。
3. `swift build && swift test` 確認綠。
4. 把改過的 `FormatRule.swift` 與重生成的 `FormatRule+SafeOverloads.swift` 一起 commit。不要手改 `FormatRule+SafeOverloads.swift`（檔頭標 GENERATED）——要改簽名就改 `FormatRule.swift` 後重跑 codegen。

#### 規範

case 形狀決定生成幾個 overload：

| 形狀 | 範例 | 生成 |
|---|---|---|
| 純 Flag | `case andOperator(rule: Flag)` | enable / disable 各一 |
| Flag + option | `case braces(rule: Flag, allman: Toggle = .disable)` | enable / disable / 診斷 三個 |
| 全域 option（無 Flag） | `case typeBlankLines(mode: ... = .preserve)` | 單一 passthrough，無 enable/disable |
| deprecated | `@available(*, deprecated, renamed:) case ...` | 保留相容 factory、不做型別安全拆分 |

- **option 一律給預設值**：disable overload 不帶任何 option、靠 storage case 的預設值補齊；沒給預設值的 option 會讓 disable overload 缺引數、編不過。少數確實無法給預設的情形，codegen 會合成 `""` / `0` / `[]` / `nil`；遇到無法合成的型別會在報告報錯，不要忽略。
- **`_` 前綴由 codegen 管理**：storage case 的加前綴與還原都由 codegen 處理、可重複 re-run 不會雙前綴；手寫 case 時不要自己加 `_`。
- **診斷 overload**：Flag + option 的規則會多生一個 `@available(*, unavailable)` 的 `(rule: DisableToken, option…)` overload，用來在 `.disable` 誤帶 option 時給出客製編譯錯誤訊息，而不是讓 option 被默默忽略。
