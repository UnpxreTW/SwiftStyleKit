//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

// swiftlint:disable file_length
// 原因：FormatRule case 隨 逐條對應 swiftformat 規則（總計 107 條）、case 必須宣告在
// main enum body（Swift 語言限制、不能拆 extension），預期最終 ~500-600 行；
// file_length 預設 400 在這場景對品質沒指引意義

// swiftlint:disable type_body_length
// 原因：21 option 的 organizeDeclarations case 簽名為了一個 element 一行而拉長
// enum body、超 250 行門檻；file_length 場景同理（已 disable）

/// 格式規則
///
/// 每個 case 對應 swiftformat 一條 rule，Mirror reflection 自動展開為 CLI 參數。
///
/// 漸進遷移中：規則逐條搬進巢狀 ``Storage`` enum、改由型別安全的 `.on` / `.off` static func
/// 工廠建立（已遷者由載體 case ``_storage(_:)`` 承載）；尚未遷的維持原 `case`、以 `rule: Flag` 建立。
/// 全部遷完後 FormatRule 會轉成 struct、``Storage`` 改 internal。
public enum FormatRule {

	/// 在最後一個 `guard` 後強制插入空白行；連續多個 `guard` 之間由 `lineBetweenGuards` 控
	///
	/// `lineBetweenGuards` 簽名預設 `.disable`（與上游 `false` 一致）：連續 guard 連成一塊
	/// early return 區。設 `.enable` 則連續 guard 之間也插空行。
	case blankLinesAfterGuardStatements(rule: Flag, lineBetweenGuards: Toggle = .disable)

	/// 在 `MARK:` 註解前後插入空白行
	case blankLinesAroundMark(rule: Flag, lineAfterMarks: Toggle = .enable)

	/// 移除 scope 結尾的空白行
	///
	/// type 宣告結尾的空白行行為由全域 option ``typeBlankLines(mode:)`` 控制。
	case blankLinesAtEndOfScope(rule: Flag)

	/// 移除 scope 起始的空白行
	///
	/// type 宣告開頭的空白行行為由全域 option ``typeBlankLines(mode:)`` 控制。
	case blankLinesAtStartOfScope(rule: Flag)

	/// 移除鏈式呼叫之間的空白行（保留換行）
	case blankLinesBetweenChainedFunctions(rule: Flag)

	/// 移除 import 陳述式之間的空白行
	case blankLinesBetweenImports(rule: Flag)

	/// 在型別與函式宣告之間插入空白行
	case blankLinesBetweenScopes(rule: Flag)

	/// 把 block comment `/* */` 轉成連續 single-line（DocC `/**` 轉成 `///`、一般轉成 `//`）
	///
	/// 規則無 own option；內部自動分辨 DocC 跟一般 block comment、轉成對應 single-line 形式。
	case blockComments(rule: Flag)

	/// 依選定風格擺放大括號
	///
	/// `allman` 為 `.enable` 時開大括號換行（Allman）、`.disable` 時同行（K&R）。
	case braces(rule: Flag, allman: Toggle = .disable)

	/// 用 `if` / `switch` 運算式做條件賦值
	///
	/// `mode` 為 `.afterProperty` 只改寫新屬性宣告後的賦值、`.always` 連既有
	/// lvalue 的賦值也改。Swift 5.9+ 才有此語法、低於 5.9 規則自動 no-op。
	case conditionalAssignment(rule: Flag, mode: ConditionalAssignmentMode = .always)

	/// 連續多個空白行收成一個
	case consecutiveBlankLines(rule: Flag)

	/// 連續多個空格收成一個
	case consecutiveSpaces(rule: Flag)

	/// 讓 `switch` 內各 case 的間距一致
	case consistentSwitchCaseSpacing(rule: Flag)

	/// API 宣告用 doc comment（`///`）、其他用一般註解（`//`）
	///
	/// `mode` 為 `.beforeDeclarations` 雙向正規化、`.preserve` 只升級不降級。
	case docComments(rule: Flag, mode: DocCommentsMode = .beforeDeclarations)

	/// doc comment 移到宣告的修飾詞 / attribute 之前
	case docCommentsBeforeModifiers(rule: Flag)

	/// 移除重複的 import 陳述式
	case duplicateImports(rule: Flag)

	/// `else` / `catch` / `repeat`-`while` 關鍵字依風格擺位
	///
	/// `elsePosition` 管 `else` / `catch`、`guardElse` 管 `guard` 的 `else`。
	case elseOnSameLine(rule: Flag, elsePosition: ElsePosition = .sameLine, guardElse: GuardElsePosition = .nextLine)

	/// 移除空大括號內的空白
	case emptyBraces(rule: Flag, mode: EmptyBracesSpacing = .noSpace)

	/// 移除空的、不宣告 protocol 一致性的 extension
	case emptyExtensions(rule: Flag)

	/// 只裝靜態成員的型別轉成 `enum` 命名空間
	///
	/// `mode` 為 `.always` 連 `final class` 也轉、`.structsOnly` 只轉 `struct`。
	case enumNamespaces(rule: Flag, mode: EnumNamespacesMode = .always)

	/// 把 SwiftUI `EnvironmentValues` 定義改寫成使用 `@Entry` macro
	///
	/// `@Entry` macro 需 Swift 6.0+（Xcode 16）、低於 6.0 規則自動 no-op。
	case environmentEntry(rule: Flag)

	/// 設定 extension 的存取控制修飾詞擺位
	///
	/// `mode` 為 `.onExtension` 放在 `extension` 上、`.onDeclarations` 下放到成員。
	case extensionAccessControl(rule: Flag, mode: ExtensionACLPlacement = .onDeclarations)

	/// 套用統一的檔案標頭
	///
	/// `header` 為標頭內容（`strip` / `ignore` / 模板文字），`dateFormat`、`timeZone`
	/// 供模板日期 token 使用。此規則不在 `allRules`——標頭內容隨專案而異、由 plugin 執行期組裝。
	case fileHeader(rule: Flag, header: String, dateFormat: String, timeZone: String)

	/// 統一偏好 `#file` 或 `#fileID`
	///
	/// `mode` 選 `.file` 或 `.fileID`。Swift 6 language mode 起兩者行為相同、規則於低於
	/// Swift 6 時自動 no-op；`#filePath` 不受影響。
	case fileMacro(rule: Flag, mode: FileMacro = .fileID)

	/// 用角括號泛型語法改寫型別約束式 extension
	///
	/// `genericTypes` 為分號分隔的自訂泛型型別清單（如 `"LinkedList<Element>"`）、讓規則
	/// 認得自訂型別；`nil` 則只處理內建型別。角括號 extension 語法需 Swift 5.7+。
	case genericExtensions(rule: Flag, genericTypes: String? = nil)

	/// 確保 header 註解裡的檔名與實際檔名相符
	case headerFileName(rule: Flag)

	/// 把行內 `await` 移到表達式開頭
	///
	/// `asyncCapturing` 為帶 async `@autoclosure` 參數的函式清單、其呼叫點的 `await`
	/// 不外搬；`nil` 表無此類函式。需 Swift 5.5+。
	case hoistAwait(rule: Flag, asyncCapturing: String? = nil)

	/// 重新擺放 pattern 裡的 `let` / `var` binding
	///
	/// `mode` 為 `.hoist` 把 `let` 一次提到 pattern 最前、`.inline` 讓每個 binding 各自帶 `let`。
	case hoistPatternLet(rule: Flag, mode: PatternLet = .hoist)

	/// 把行內 `try` 移到表達式開頭
	///
	/// `throwCapturing` 為帶 throwing `@autoclosure` 參數的函式清單、其呼叫點的 `try`
	/// 不外搬；`nil` 表無此類函式。
	case hoistTry(rule: Flag, throwCapturing: String? = nil)

	/// 依 scope 層級縮排程式碼
	///
	/// `indent` 縮排單位、`tabWidth` tab 視覺寬度（`nil` 為 unspecified）、`smartTabs`
	/// 對齊獨立於 tab 寬度、`indentCase` switch 內 case 是否多縮一層、`ifdef` `#if`
	/// 區塊縮排方式、`xcodeIndentation` 是否對齊 Xcode 縮排、`indentStrings` 多行字串
	/// 是否跟著縮排。
	case indent(
		rule: Flag,
		indent: Indentation = .tab,
		tabWidth: Int? = nil,
		smartTabs: Toggle = .enable,
		indentCase: Toggle = .disable,
		ifdef: IfdefIndent = .outdent,
		xcodeIndentation: Toggle = .disable,
		indentStrings: Toggle = .enable
	)

	/// 替未實作的 `required init(coder:)` 加 `@available(*, unavailable)`
	///
	/// `initCoderNil` 為 `.enable` 時把 unavailable `init?(coder:)` 的 `fatalError` 換成 `nil`。
	case initCoderUnavailable(rule: Flag, initCoderNil: Toggle = .disable)

	/// 把 `foo.count == 0` 改寫成 `foo.isEmpty`、`foo.count > 0` 改寫成 `!foo.isEmpty`
	///
	/// **Footgun**：規則只看 `.count` token pattern、不知 type 是否有 `isEmpty` property。
	/// 對自訂 type 暴露 `.count` 但無 `.isEmpty` 改寫後編譯 fail。標準 `Collection`
	/// 安全；上游因此 disabled by default。
	case isEmpty(rule: Flag)

	/// 把行首的分隔符移到上一行行尾
	case leadingDelimiters(rule: Flag)

	/// 確保檔案結尾有換行
	case linebreakAtEndOfFile(rule: Flag)

	/// 把所有換行字元統一成指定的型式
	///
	/// `mode` 選 `.lf`（Unix）、`.crlf`（Windows）或 `.cr`。
	case linebreaks(rule: Flag, mode: Linebreak = .lf)

	/// 在 top-level 型別與 extension 前加 `MARK:` 註解
	///
	/// `markTypes` / `markExtensions` 各自控制型別、extension 的標記時機；`typeMark`
	/// / `extensionMark` / `groupedExtension` 為對應的 MARK 模板（`nil` 用 swiftformat
	/// 預設）。
	case markTypes(
		rule: Flag,
		markTypes: MarkMode = .always,
		typeMark: String? = nil,
		markExtensions: MarkMode = .always,
		extensionMark: String? = "MARK: - + %c",
		groupedExtension: String? = "MARK: - + %c"
	)

	/// 成員修飾詞依一致順序排列
	///
	/// `modifierOrder` 為逗號分隔的修飾詞偏好順序清單；`nil` 用 swiftformat 內建預設順序。
	case modifierOrder(rule: Flag, modifierOrder: String? = nil)

	/// 確保所有修飾詞與宣告關鍵字在同一行
	case modifiersOnSameLine(rule: Flag)

	/// 移除 Swift 5.9+ 的 `borrowing` / `consuming` 顯式 ownership modifier
	///
	/// 退回 Swift 預設 ownership 規則（compiler 自動決定）。適用「不在意 ownership 細節」場景。
	case noExplicitOwnership(rule: Flag)

	/// 測試中用 `throws` 取代 `try!`
	case noForceTryInTests(rule: Flag)

	/// 測試中用 `#require` / `XCTUnwrap` 取代強制解包
	case noForceUnwrapInTests(rule: Flag)

	/// 把測試內 `guard ... else { XCTFail/return }` pattern 改寫成 `try XCTUnwrap` / `try #require`
	case noGuardInTests(rule: Flag)

	/// 數字字面值依型別一致分組、並統一 hex / 指數字母大小寫
	///
	/// 四個 `*Grouping` 為「群組大小,套用門檻」（或 `none` / `ignore`、`nil` 用上游預設）；
	/// `fractionGrouping` / `exponentGrouping` 控制小數、指數位數是否分組；`hexLiteralCase`
	/// / `exponentCase` 控制 hex 字母與指數 `e` 的大小寫。
	case numberFormatting(
		rule: Flag,
		decimalGrouping: String? = "3,5",
		binaryGrouping: String? = "4,4",
		octalGrouping: String? = "4,4",
		hexGrouping: String? = "4,4",
		fractionGrouping: Toggle = .enable,
		exponentGrouping: Toggle = .disable,
		hexLiteralCase: LetterCase = .uppercase,
		exponentCase: LetterCase = .lowercase
	)

	/// 對 class/struct/enum/actor/extension body 內的宣告整體重新組織排序
	///
	/// - `organizationMode`：依 visibility 或 type 為主軸組織
	/// - `visibilityOrder`：自訂 visibility group 順序
	/// - `typeOrder`：自訂 type group 順序
	/// - `visibilityMarks`：自訂 visibility group MARK 文字
	/// - `typeMarks`：自訂 type group MARK 文字
	/// - `categoryMark`：MARK 模板字串
	/// - `markCategories`：是否插入 MARK 標頭
	/// - `beforeMarks`：放在第一個 MARK 之前的 declaration types
	/// - `lifecycle`：自訂 lifecycle method 名單（加進 instanceLifecycle 群組）
	/// - `organizeTypes`：哪些 type 要被 organize
	/// - `classThreshold` / `structThreshold` / `enumThreshold` / `extensionThreshold`：觸發 organize 的最小行數
	/// - `markClassThreshold` / `markStructThreshold` / `markEnumThreshold` / `markExtensionThreshold`：觸發 MARK 標頭的最小行數
	/// - `sortSwiftUIProperties`：SwiftUI property 排序模式
	/// - `typeBodyMarks`：type body 內既有 MARK 處理
	/// - `groupBlankLines`：subgroup 之間是否插空行
	case organizeDeclarations(
		rule: Flag,
		organizationMode: DeclarationOrganizationMode = .visibility,
		visibilityOrder: [String]? = [
			"beforeMarks",
			"open",
			"public",
			"package",
			"instanceLifecycle",
			"internal",
			"fileprivate",
			"private"
		],
		typeOrder: [String]? = [
			"nestedType",
			"staticProperty",
			"staticPropertyWithBody",
			"staticMethod",
			"classPropertyWithBody",
			"classMethod",
			"swiftUIProperty",
			"overriddenProperty",
			"swiftUIPropertyWrapper",
			"instancePropertyWithBody",
			"instanceProperty",
			"overriddenMethod",
			"swiftUIMethod",
			"instanceMethod"
		],
		visibilityMarks: String? = "fileprivate:File Private",
		typeMarks: String? = nil,
		categoryMark: String? = nil,
		markCategories: Toggle = .enable,
		beforeMarks: [String]? = nil,
		lifecycle: [String]? = [
			"viewDidLoad",
			"viewWillAppear",
			"viewDidAppear",
			"viewWillDisappear",
			"viewDidDisappear",
			"viewWillLayoutSubviews",
			"viewDidLayoutSubviews",
			"setUp",
			"tearDown",
			"setUpWithError",
			"tearDownWithError"
		],
		organizeTypes: [String]? = nil,
		classThreshold: Int? = nil,
		structThreshold: Int? = nil,
		enumThreshold: Int? = nil,
		extensionThreshold: Int? = nil,
		markClassThreshold: Int? = 80,
		markStructThreshold: Int? = 80,
		markEnumThreshold: Int? = 80,
		markExtensionThreshold: Int? = 80,
		sortSwiftUIProperties: SwiftUIPropertiesSortMode = .firstAppearanceSort,
		typeBodyMarks: TypeBodyMarks = .remove,
		groupBlankLines: Toggle = .enable
	)

	/// 用 opaque 泛型參數（`some Protocol`）取代有約束的泛型參數
	///
	/// `someAny` 為 `.enable` 時把無約束的泛型參數也轉成 `some Any`。需 Swift 5.7+。
	case opaqueGenericParameters(rule: Flag, someAny: Toggle = .enable)

	/// 偏好 `count(where:)` 取代 `filter(_:).count`
	///
	/// `count(where:)` 需 Swift 6.0+、低於版本規則自動 no-op。
	case preferCountWhere(rule: Flag)

	/// 把 `!flag` 改寫成 `flag == false`
	case preferExplicitFalse(rule: Flag)

	/// 在 class 前自動加 `final`（`open class` / 名稱含 `Base` / 同檔被 subclass 等自動保留）
	case preferFinalClasses(rule: Flag)

	/// 把函式式 `forEach` 呼叫轉成 `for` 迴圈
	///
	/// `anonymousForEach` 為 `.ignore` 時保留匿名 forEach（用 `$0` 的形式）、
	/// `singleLineForEach` 為 `.ignore` 時保留單行 forEach。
	case preferForLoop(
		rule: Flag,
		anonymousForEach: ForEachConversion = .ignore,
		singleLineForEach: ForEachConversion = .ignore
	)

	/// 把 `map { $0.foo }` 等簡單 closure 改成 keyPath 寫法 `map(\.foo)`
	///
	/// 需 Swift 5.2+（key path as function）、低於版本規則自動 no-op。
	case preferKeyPath(rule: Flag)

	/// 把 Objective-C bridged String method 改寫成 Swift 5.7+ 等價（`replacingOccurrences` → `replacing` 等）
	case preferSwiftStringAPI(rule: Flag)

	/// 把 XCTest 整個改寫成 Swift Testing（`XCTestCase` → `@Test`、`XCTAssert*` → `#expect`）
	///
	/// - `defaultTestSuiteAttributes`：轉換時自動加的 attributes 列表（如 `["@MainActor"]`）
	/// - `xctestSymbols`：fork 自訂額外 XCTest 依賴 symbol（規則用來判斷是否真的依賴 XCTest）
	/// Swift 6.0+ gate（規則內部處理）。
	case preferSwiftTesting(
		rule: Flag,
		defaultTestSuiteAttributes: [String]? = nil,
		xctestSymbols: [String]? = nil
	)

	/// 給 `@State` / `@StateObject` 沒帶訪問控制的 property 自動加 `private`
	case privateStateVariables(rule: Flag)

	/// 控制 property 宣告用顯式 type 或推導
	///
	/// SwiftStyleKit 簽名預設選 `.explicit`、所有 property 都顯式（跟 `redundantType .explicit`
	/// 同調、一致性最高）。
	///
	/// **Footgun**：規則對 `let x = Type.staticMethod()` 一律假設 `staticMethod` 回 `Type`、
	/// 不看 method 簽名。當 static method 實際回不同型別（如 factory 回 Optional / tuple）
	/// 自洗後編譯 fail；對應 call site 用 `// swiftformat:disable propertyTypes` directive
	/// 局部豁免、或改用 `let x: ActualType = Type.staticMethod()` 手寫正確標註。
	///
	/// - `propertyTypes`：模式選擇（`.explicit` / `.inferred` / `.inferLocalsOnly`、上游預設
	///   `.inferLocalsOnly`）
	/// - `inferredTypes`：推導適用範圍（`.always` 全推導 / `.excludeCondExprs` 條件式保留顯式、
	///   上游預設 `.always`）；只在 `propertyTypes = .inferred` 時生效、對 SwiftStyleKit
	///   `.explicit` 簽名無作用、純為 fork 簽名 hint
	/// - `preservedPropertyTypes`：保留顯式型別的 type 名單；SwiftStyleKit 簽名 `nil`
	///   不保留任何（上游預設 `["Package"]` 為 SPM Package.swift 識別、但 SPM 識別實際依
	///   檔名 + import、不純依顯式型別）；同樣只在 `.inferred` / `.inferLocalsOnly` 模式生效
	case propertyTypes(
		rule: Flag,
		propertyTypes: PropertyTypes = .explicit,
		inferredTypes: InferredTypesMode = .always,
		preservedPropertyTypes: [String]? = nil
	)

	/// 移除不含 `await` 的函式宣告中多餘的 `async` 關鍵字
	///
	/// `mode` 為 `.testsOnly` 只動測試函式、`.always` 連一般函式也動（可能讓 call site
	/// 的 `await` 觸發 warning）。
	case redundantAsync(rule: Flag, redundantAsync: RedundantEffectMode = .testsOnly)

	/// 移除識別字外多餘的 backticks
	case redundantBackticks(rule: Flag)

	/// 移除 switch case 裡多餘的 `break`
	case redundantBreak(rule: Flag)

	/// 移除多餘的、立即呼叫的單敘述 closure（`let x = { Foo() }()` → `let x = Foo()`）
	case redundantClosure(rule: Flag)

	/// 移除 SwiftUI result builder 中多餘的 `else { EmptyView() }` 分支
	case redundantEmptyView(rule: Flag)

	/// 移除手寫的 `Equatable` 實作（當編譯器自動合成版本等價時）
	///
	/// `equatableMacro` 為 `"@MacroName,ModuleName"` 格式，告訴規則某個自訂 Equatable
	/// macro 等同於手寫 `==`；`nil` 表無自訂 macro。
	case redundantEquatable(rule: Flag, equatableMacro: String? = nil)

	/// 移除 extension 內成員上與 extension ACL 重複的存取控制修飾詞
	case redundantExtensionACL(rule: Flag)

	/// 當 `fileprivate` 與 `private` 等價時、改用 `private`
	///
	/// Swift 4+ 的 `private` 對同檔同型別 extension 已可見、需 Swift 4+。
	case redundantFileprivate(rule: Flag)

	/// 移除唯讀 computed property 中多餘的 `get { }` 包裝
	case redundantGet(rule: Flag)

	/// 移除不必要的 `.init(...)` 呼叫（`String.init("x")` → `String("x")`）
	///
	/// 內部對「`< Swift 6.4` 的 trailing closure 接在陣列字面值後」邊角自動保留 `.init`。
	case redundantInit(rule: Flag)

	/// 移除冗餘的 `internal` access control（Swift 預設層級即是 internal）
	case redundantInternal(rule: Flag)

	/// 移除忽略變數中冗餘的 `let`/`var`（`let _ = foo()` → `_ = foo()`）
	case redundantLet(rule: Flag)

	/// 移除 `catch` 子句中冗餘的 `let error`（`catch let error` → `catch`）
	case redundantLetError(rule: Flag)

	/// 移除可被自動合成的手寫 memberwise init
	///
	/// `mode` 簽名預設 `.never`（與上游一致）：保守、只移除明顯冗餘的 init。
	/// 設 `.always` 對所有 internal struct 把 private property 改 internal、讓 synthesized init 取代。
	/// 設 `.conformances(["View", "ViewModifier"])` 只對 conform 指定 SwiftUI protocol 的 struct 做。
	///
	/// 規則無整體 swift-version gate；< Swift 6.4 對「含 result builder attribute 的 non-generic
	/// struct」自動跳過避免合成 init runtime crash（[swiftlang #86272](https://github.com/swiftlang/swift/pull/86272)），其他情境照常處理。
	///
	/// **權限控制行為（保守、不偷改 API 邊界）**：
	/// - `public` / `package` init **永遠不動**（合成 init 不會升 public）
	/// - 整體判定「手寫 init 訪問控制 == 假設拿掉後合成 init 訪問控制」**完全相同**才移除
	/// - `.always` / `.conformances` 唯一主動改寫：把 `private` stored property 改 `internal`、
	///   讓合成 init 維持 `.internal`——這是 mode 明確設計、非隱式變更
	/// - 以下情境保留手寫 init：failable init（`init?` / `init!`）、帶 attribute
	///   （`@inlinable` / `@usableFromInline`）、有 doc comment、parameter 帶 default value、
	///   external label ≠ internal label、struct 有多個 init（compiler 不會合成）
	case redundantMemberwiseInit(rule: Flag, mode: PreferSynthesizedInitMode = .never)

	/// 移除被 internal/private type 包住的冗餘 `public` 訪問控制（`public let` 在 internal struct 內）
	case redundantPublic(rule: Flag)

	/// 移除 non-public struct/enum 內冗餘的 `Sendable` conformance（編譯器已自動合成）
	///
	/// public type 因 API contract 不可省、規則只動 non-public。對齊 Swift 5.5+ 自動 Sendable 合成行為。
	case redundantSendable(rule: Flag)

	/// 移除無參數的 `@Suite` / `@Suite()` attribute（含 `@Test` 的 struct 自動視為 suite）
	///
	/// 帶參數的 `@Suite(.serialized)` / `@Suite("description")` 不動。
	case redundantSwiftTestingSuite(rule: Flag)

	/// 移除 function declaration 中冗餘的 `throws`（body 內不 throw）
	///
	/// `redundantThrows` 簽名預設 `.testsOnly`（與上游一致）：只動測試函式。
	/// 設 `.always` 對所有函式都移除（可能讓既有 call site 的 `try` 變 warning）。
	case redundantThrows(rule: Flag, redundantThrows: RedundantEffectMode = .testsOnly)

	/// 簡化「立 var、立刻 return」這種冗餘 pattern（`let foo = Foo(); return foo` → `return Foo()`）
	///
	/// 取代上游已 deprecated 的 `redundantProperty` 規則。
	case redundantVariable(rule: Flag)

	/// 移除冗餘的 `@ViewBuilder` attribute（如 `body`、或內部已用 VStack 包住的 helper computed property）
	///
	/// 保留：返多個 top-level views 的 computed property（確實需要 ViewBuilder）。
	case redundantViewBuilder(rule: Flag)

	/// Optional `var` 的 `= nil` 預設值移除或插入（僅作用於 `var`、不影響非 nil 初始化）
	case redundantNilInit(rule: Flag, mode: NilInitMode = .remove)

	/// 移除冗餘的 `@objc` 標註（已有 `@IBOutlet`/`@IBAction`/`@NSManaged` 等隱含 `@objc` 的標註時）
	case redundantObjc(rule: Flag)

	/// 移除 optional binding 中冗餘的同名 identifier（Swift 5.7+、SE-0345）
	///
	/// `if let foo = foo` → `if let foo`、`guard let self = self else` → `guard let self else`。
	case redundantOptionalBinding(rule: Flag)

	/// 移除冗餘的括號（`if (foo)`、`queue.async() { ... }`、`({ ... })()` 等）
	case redundantParens(rule: Flag)

	/// 移除 pattern matching 中冗餘的 `_` 參數語法
	///
	/// `if case .foo(_, _) = bar` → `if case .foo = bar`、`let (_, _) = bar` → `let _ = bar`。
	/// 規則只動「`(_, _)` 後緊跟 `:`（switch case）或 `=`（pattern assignment）」的情境、
	/// 閉包參數（`(_, _) in ...`）不受影響。
	case redundantPattern(rule: Flag)

	/// 移除 `String` enum case 與 case 名同名的冗餘 raw value（`case bar = "bar"` → `case bar`）
	case redundantRawValues(rule: Flag)

	/// 移除可省略的 `return` 關鍵字
	///
	/// 涵蓋：單行 closure、Swift 5.1+ 單一表達式 computed property / function（SE-0255）、
	/// Swift 5.9+ if / switch expression（SE-0380、配合 ``conditionalAssignment(rule:mode:)`` 規則）。
	case redundantReturn(rule: Flag)

	/// 插入 / 移除顯式 `self.` 的策略（含 `@autoclosure` 函式白名單）
	///
	/// - `mode`：策略（`.remove` / `.insert` / `.initOnly`）。`init-only` 僅在 `init` 內保留或補上
	///   `self.`、其他位置依語境移除。closure capture / 參數同名等 Swift 編譯必要的 `self.` 規則
	///   不會動到。
	/// - `selfRequired`：以逗號分隔的「需要 self」函式名清單、供帶 `@autoclosure` 參數的函式使用
	///   （如 Nimble `expect()`、swiftformat 內建已排除）。
	case redundantSelf(rule: Flag, mode: SelfMode = .initOnly, selfRequired: String? = nil)

	/// 移除 static / class context 中冗餘的 `Self.`（`[Self.active]` → `[active]`）
	///
	/// 配對 ``redundantSelf(rule:mode:selfRequired:)``——`redundantStaticSelf` 管 static `Self.`、
	/// 單純 remove、無 option。
	case redundantStaticSelf(rule: Flag)

	/// 移除冗餘的型別標註（含 Swift 5.9+ if/switch expression、SE-0380）
	///
	/// 不帶 mode 參數：型別推導模式由 `--property-types` 選項控制、與 ``propertyTypes`` 規則共用，
	/// 統一在 ``propertyTypes`` 設定（SwiftStyleKit 選 `.explicit`）。swiftformat 0.55.0 起此選項
	/// 由 `--redundant-type` 改名為 `--property-types`、在此另設只會 emit 已 deprecated 的舊名。
	case redundantType(rule: Flag)

	/// 簡化冗餘的 typed throws（Swift 6.0+、SE-0413）
	///
	/// `throws(Never)` → 移除（字面寫法等同 non-throwing）；`throws(any Error)` → `throws`。
	/// 規則只動字面 `Never`、不會碰泛型參數 `throws(E)` instantiation 為 `Never` 的情境
	/// （那是 SE-0413 取代 `rethrows` 的設計核心）。
	case redundantTypedThrows(rule: Flag)

	/// 移除冗餘的 `-> Void` 回傳型別
	///
	/// `closureVoid` 控制 closure literal `{ () -> Void in ... }` 的處理；typealias / 函式型別宣告
	/// 不受影響。
	case redundantVoidReturnType(rule: Flag, closureVoid: ClosureVoidReturn = .remove)

	/// 移除分號
	///
	/// 行尾分號（`let x = 5;`）兩種 `mode` 都會移除；差別在同行兩 statement 的處理：
	/// `.never`（簽名預設）拆成兩行、`.inline`（swiftformat 上游預設）保留分號隔離。
	case semicolons(rule: Flag, mode: SemicolonsMode = .never)

	/// 把 `where T: Foo` clause 改成 inline `<T: Foo>` 寫法
	///
	/// 例如 `struct Foo<T> where T: Hashable {}` 改寫成 `struct Foo<T: Hashable> {}`。
	/// 只處理簡單 protocol conformance；複雜條件（`where T == Int`、混合 same-type requirement）不動。
	case simplifyGenericConstraints(rule: Flag)

	/// 一行多 property 宣告拆成一行一個
	///
	/// 例如 `let a, b, c: Int` 拆成三行各自宣告；`let (foo, bar) = ("foo", "bar")` tuple
	/// destructuring 也拆。對 `let (foo, bar) = methodCallWithPossibleSideEffects()`
	/// 自動 preserve（避免 method 被呼叫兩次）。
	case singlePropertyPerLine(rule: Flag)

	/// 對帶有 sort 標註的宣告排序（marker-based opt-in）
	///
	/// swiftformat 用 `isCommentBody.contains` 比對 comment 字串、找尋形如 `(規則名):sort`
	/// 的標註。兩種觸發方式：(1) 標註放在宣告前、對整個 body 排序；(2) 用 `(規則名):sort:begin`
	/// 與 `(規則名):sort:end` 包住範圍。實際 marker 字串請見 swiftformat Rules.md。
	///
	/// 註：本 doc 刻意不寫 marker 字面字串、避免 swiftformat 在自己的 source 上掃到 doc 內容
	/// 把它當真的標註、token range 計算失敗（debug build 觸發 fatal assert）。
	case sortDeclarations(rule: Flag)

	/// 對 import 語句字母排序、`#if` 區塊內各自排序
	///
	/// `mode` 預設 `.testableFirst`（`@testable` import 集中排前面、各組內部字母排序）；
	/// swiftformat 上游預設為 `.alpha`。
	case sortImports(rule: Flag, mode: ImportGrouping = .testableFirst)

	/// 對所有 switch case 字母排序（無 option）
	///
	/// 規則啟用後**所有** switch case 字串都會被字母重排、不限於加標註的位置（與
	/// ``sortDeclarations(rule:)`` 的 marker-based 設計不同）。對「按 priority / state
	/// machine / by domain」排序的場景會洗掉業務語意、SwiftStyleKit 預設 `.disable`。
	case sortSwitchCases(rule: Flag)

	/// 對 protocol composition typealias 字母排序（`Foo & Bar & Baaz` → `Baaz & Bar & Foo`）
	case sortTypealiases(rule: Flag)

	/// 正規化大括號周圍空格（trailing closure 前補 space、paren 與 brace 間冗餘 space 移除）
	case spaceAroundBraces(rule: Flag)

	/// 正規化方括號 `[]` 周圍空格（type casting 前補 space、subscript 前冗餘 space 移除）
	case spaceAroundBrackets(rule: Flag)

	/// 註解周圍補空白（行內 `// comment` 前補 space、`/* ... */` 區塊註解前後補 space）
	case spaceAroundComments(rule: Flag)

	/// 移除泛型角括號 `<>` 前的空白（`Foo <Bar>` → `Foo<Bar>`）
	case spaceAroundGenerics(rule: Flag)

	/// 正規化 operator / type delimiter 周圍空白（4 個 option 控不同位置）
	///
	/// - `operatorFunc` 簽名預設 `.remove`：operator function 宣告 `func ==(` 緊貼
	/// - `ranges` 簽名預設 `.insert`：range operator `a ..< b` 兩側留空（與一般 binary
	///   operator 寫法一致；上游預設亦同）
	/// - `typeDelimiter` 簽名預設 `.spaceAfter`：型別冒號 `foo: Int`（Swift 標準）
	/// - `noSpaceOperators` 簽名預設 `nil`：fork 端可填白名單字串陣列指定哪些
	///   operator 永遠不加空白；空陣列 `[]` 與 `nil` 等效（皆不展開該 flag）
	case spaceAroundOperators(
		rule: Flag,
		operatorFunc: OperatorSpacing = .remove,
		ranges: OperatorSpacing = .insert,
		typeDelimiter: DelimiterSpacing = .spaceAfter,
		noSpaceOperators: [String]? = nil
	)

	/// 正規化括號 `()` 周圍空白（`init (foo)` → `init(foo)`、`switch(x){` → `switch (x) {`）
	case spaceAroundParens(rule: Flag)

	/// single-line 大括號內部兩端補空白（`{return x}` → `{ return x }`、空 `{}` 與巢狀不動）
	case spaceInsideBraces(rule: Flag)

	/// 移除方括號內側空白（`[ 1, 2, 3 ]` → `[1, 2, 3]`、下一個 token 為 comment 時不動）
	case spaceInsideBrackets(rule: Flag)

	/// 註解標記後補空白（`//x` → `// x`、`///x` → `/// x`、`/*x*/` → `/* x */`、保留 `// ===` 等格式化結構）
	case spaceInsideComments(rule: Flag)

	/// 移除泛型角括號 `<>` 內側空白（`Foo< Bar, Baz >` → `Foo<Bar, Baz>`）
	case spaceInsideGenerics(rule: Flag)

	/// 移除圓括號 `()` 內側空白（`( a, b )` → `(a, b)`、下一個 token 為 comment 時不動）
	case spaceInsideParens(rule: Flag)

	/// 移除 `@IBOutlet weak var` 冗餘的 `weak`（Apple WWDC 2015 建議；名稱以 `delegate`/`datasource` 結尾不動）
	case strongOutlets(rule: Flag)

	/// 移除 `guard let \`self\` = self` 冗餘 backticks（Swift 4.2+ gate、低於版本自動 no-op）
	case strongifiedSelf(rule: Flag)

	/// 格式化 Swift Testing `@Test` / `@Suite` 名稱
	///
	/// - `testCaseNameFormat` 簽名預設 `.rawIdentifiers`：把 `@Test("中文描述")` 字串提升到
	///   function 名本體（轉成 backtick 包覆的 raw identifier）、移除 `@Test` 描述參數
	/// - `suiteNameFormat` 簽名預設 `.preserve`：不動既有 `@Suite("…")` struct/class/actor/enum 名
	/// - Swift 6.2+ gate（規則內部處理；`.rawIdentifiers` 模式對低版本自動 no-op，`.standardIdentifiers` 模式無版本限制）
	case swiftTestingTestCaseNames(
		rule: Flag,
		testCaseNameFormat: SwiftTestingNameFormat = .rawIdentifiers,
		suiteNameFormat: SwiftTestingNameFormat = .preserve
	)

	/// test method 統一成設定的 access control、test suite 內非 test 的成員強制 private
	///
	/// `testCaseAccessControl` 簽名預設 `.private`（SwiftStyleKit 選擇、嚴格化 test
	/// 為純 entry point）；swiftformat 上游預設 `.internal`。對 XCTest（ObjC runtime
	/// 自動 discover private test）與 swift-testing（`@Test` macro 內 expand entry hook）
	/// 都有效。
	case testSuiteAccessControl(rule: Flag, testCaseAccessControl: TestCaseAccessControl = .private)

	// swiftlint:disable:next todo
	/// 規範 `TODO:` / `MARK:` / `FIXME:` 註解格式（大寫 + 冒號；`TODOfoo` 無 space 後綴視為自訂 tag、不動）
	case todos(rule: Flag)

	/// 把 `foo(execute: { ... })` 轉成 trailing closure 寫法 `foo { ... }`
	///
	/// 規則內建 `async` / `asyncAfter` / `sync` / `autoreleasepool` 永遠轉 trailing；
	/// `performBatchUpdates` / `expect`（Nimble）永遠保留括號內 closure。
	///
	/// - `trailingClosures` 簽名預設 `nil`：fork 自訂額外 always-trailing 函式名單
	///   （`nil` 與 `[]` 等效不展開該 flag）
	/// - `neverTrailing` 簽名預設 `nil`：fork 自訂額外 never-trailing 函式名單
	case trailingClosures(
		rule: Flag,
		trailingClosures: [String]? = nil,
		neverTrailing: [String]? = nil
	)

	/// multi-line 列表加/移除 trailing comma
	///
	/// `mode` 簽名預設 `.never`：移除所有 trailing comma。對齊 swiftlint
	/// `trailing_comma` 規則預設行為（mandatory_comma: false → 要求無 trailing
	/// comma）+ SwiftStyleKit歷史 codebase 99% 風格。上游預設為 `.always`。
	case trailingCommas(rule: Flag, mode: TrailingCommas = .never)

	/// 清行尾空白（含純空白行的縮排）
	///
	/// `mode` 簽名預設 `.always`：上游預設、清行尾空白 + 清純空白行的縮排。
	/// 設 `.nonblankLines` 改為只清非空白行尾空白、保留純空白行縮排（適合
	/// 「按 Enter 後光標自動縮排」這類編輯器體驗）。
	case trailingSpace(rule: Flag, mode: TrimWhitespace = .always)

	/// `Optional<T>` / `Array<T>` / `Dictionary<K, V>` → `T?` / `[T]` / `[K: V]` sugar 轉換
	///
	/// `mode` 簽名預設 `.preserveStructInits`：上游預設、保留 struct stored property
	/// 位置的 `Optional<T>`（防 memberwise init 默認值意外變化 footgun）；其他位置仍 sugar。
	/// `Array<T>` / `Dictionary<K, V>` 永遠 sugar、無例外。
	case typeSugar(rule: Flag, mode: OptionalsMode = .preserveStructInits)

	/// 把未使用的 function / closure argument 名改成 `_`
	///
	/// `mode` 簽名預設 `.closureOnly`：只動 closure 內未使用的 args；function declaration
	/// 不動（適合「signature 是 API contract」的場景，保留 `func foo(bar: Int)` 即使
	/// 內部沒用 `bar` 也不改寫）。上游預設為 `.all`。
	case unusedArguments(rule: Flag, mode: ArgumentStrippingMode = .closureOnly)

	/// 移除未被引用的 `private` / `fileprivate` 宣告
	///
	/// **Footgun**：規則只看 static reference、對 `@objc selector(_:)` / KVC
	/// `value(forKey:)` / Mirror reflection 等 dynamic dispatch 無感、可能誤刪。
	/// `preserveDecls` 為逗號分隔的 declaration 名單、列在內的不刪（`nil` 表無保留）。
	case unusedPrivateDeclarations(rule: Flag, preserveDecls: String? = nil)

	/// 把 `URL(string: "...")!` force-unwrap 改寫成設定的 `#URL(_:)` macro call
	///
	/// macro 在編譯期驗 URL、無效字串編譯 fail（取代 runtime crash）。
	///
	/// `urlMacro` 簽名預設 `nil`：規則啟用但不指定 macro → 自動 no-op；fork 設
	/// `"#URL,URLFoundation"` 格式（macro 名 + module 名、逗號分隔）即生效、規則
	/// 自動補 `import <module>`。
	///
	/// **Footgun**：規則純文字 add import、不檢查 module 是否可解析。Fork 設 macro
	/// 但沒在 `Package.swift` / Podfile / Xcode 加對應 dependency 時、自動補的
	/// `import <module>` 會編譯 fail（`no such module '<module>'`）。
	case urlMacro(rule: Flag, urlMacro: String? = nil)

	/// 補漏 test method 的 `test` prefix（XCTest）或 `@Test` attribute（swift-testing）
	///
	/// 規則先 detect framework（XCTest / swift-testing）、再對 test suite / class 內每個
	/// `func` 成員判斷：
	/// - **跳過**：有 `override` / `@objc` / `static` modifier、`disabled_` prefix、
	///   或 `private` / `fileprivate` modifier
	/// - **判為 test**（swift-testing）：有 `@Test` 或無 params + 無 return type
	/// - **判為 test**（XCTest）：無 params + 無 return type + 函式名整檔只出現 1 次
	///
	/// 動作：XCTest 加 `test` prefix、swift-testing 加 `@Test` attribute。
	///
	/// 對 `private func` 成員不動——故對 SwiftStyleKit 自身 *Tests.swift（皆 private）
	/// no-op、純為 fork 用戶補漏。
	case validateTestCases(rule: Flag)

	/// 規範 `Void` / `()` 用法：type 位置用 `Void`、value 位置用 `()`
	///
	/// `mode` 簽名預設 `.void`：對齊 Swift 社群標準與上游預設（`() -> Void`）。
	/// 設 `.tuple` 改為 type 位置寫 `()`（`() -> ()`）。value 位置 (`Void()` → `()`) 無例外。
	case void(rule: Flag, mode: VoidType = .void)

	/// 行寬超過 `maxWidth` 時自動換行
	///
	/// - `maxWidth` 簽名預設 `120`：常見折衷值（100 緊湊、140 寬鬆）；設 `0` 等同 disable
	/// - `noWrapOperators` 簽名預設 `nil`：fork 自訂不換行的 operator 列表（如 `[".", "?."]`
	///   保護方法鏈不被拆）；`nil` 與 `[]` 等效不展開
	/// - `assetLiterals` 簽名預設 `.actualWidth`（B 方案、上游 `.visualWidth`）：按 source code
	///   實際字數計算 `#colorLiteral` / `#imageLiteral` token 寬度；不在 Xcode 內編輯 source 時更準
	/// - `wrapTernary` 簽名預設 `.default`：三元運算式 `?` / `:` 放下一行開頭
	///
	/// 注意 `wrap-string-interpolation` 屬全域 option（同時被 `wrap` 與 `wrapArguments` own）、
	/// 已抽出至列舉底部獨立 case ``wrapStringInterpolation(mode:)``。
	case wrap(
		rule: Flag,
		maxWidth: Int = 120,
		noWrapOperators: [String]? = nil,
		assetLiterals: AssetLiteralWidth = .actualWidth,
		wrapTernary: TernaryOperatorWrapMode = .default
	)

	/// 對齊 multi-line wrap 過的 function arguments / collection elements
	///
	/// 11 個 own option 中 10 個暴露於此 case（`wrap-string-interpolation` 屬全域、抽出至底部）：
	/// - `wrapArguments` 簽名預設 `.preserve`：function call argument 換行模式
	/// - `wrapParameters` 簽名預設 `.beforeFirst`（B 方案、上游 `.preserve`）：function declaration
	///   parameter 換行模式——已 wrap 的多行參數列強制 before-first（`(` 後即換行、每參數獨立一行、
	///   `)` 配合 `closingParen: .balanced` 獨立成行接 `{`），避免 after-first 殘留 `?)` + `{` 裂行
	/// - `wrapCollections` 簽名預設 `.preserve`：collection literal element 換行模式
	/// - `wrapConditions` 簽名預設 `.beforeFirst`（B 方案、上游 `.preserve`）：conditional expression
	///   （`if` / `guard` / `while`）換行模式——已 wrap 的多行條件式把關鍵字推到獨立一行（條件接在下一行），
	///   配合 `guardElse: next-line` 讓 `else` 也獨立成行。注意：條件的「組內分行」維持來源、不強制逐條件拆
	///   （`let x = a, x.count >= 10` 仍黏一行）；單行且不超 `maxWidth` 的條件式完全不受影響
	/// - `wrapTypeAliases` 簽名預設 `.preserve`：typealias 換行模式
	/// - `wrapEffects` 簽名預設 `.preserve`：function effects（`throws` / `async`）換行
	/// - `wrapReturnType` 簽名預設 `.preserve`：function return type 換行
	/// - `closingParen` 簽名預設 `.balanced`：closing `)` 擺位（上游預設）
	/// - `callSiteParen` 簽名預設 `.balanced`：call-site closing `)` 擺位（B 方案、與 `closingParen` 一致）
	/// - `allowPartialWrapping` 簽名預設 `.enable`：允許 partial argument wrapping（上游預設）
	case wrapArguments(
		rule: Flag,
		wrapArguments: WrapMode = .preserve,
		wrapParameters: WrapMode = .beforeFirst,
		wrapCollections: WrapMode = .preserve,
		wrapConditions: WrapMode = .beforeFirst,
		wrapTypeAliases: WrapMode = .preserve,
		wrapEffects: WrapEffects = .preserve,
		wrapReturnType: WrapEffects = .preserve,
		closingParen: ParenPlacement = .balanced,
		callSiteParen: ParenPlacement = .balanced,
		allowPartialWrapping: Toggle = .enable
	)

	/// 規範 `@attribute` 擺位——換到上一行或同行
	///
	/// 5 個 `AttributeMode` option 簽名預設全部 `.prevLine`（B 方案、上游 `.preserve`）——
	/// 強調 attribute 存在感、對齊 `@Test` / SwiftUI `@State` / Concurrency `@MainActor` 慣例。
	/// - `funcAttributes`：function 上的 @attribute
	/// - `typeAttributes`：type 宣告上的 @attribute
	/// - `storedVarAttributes`：stored property 上的 @attribute
	/// - `computedVarAttributes`：computed property 上的 @attribute
	/// - `complexAttributes`：帶參數的 @attribute（如 `@available(iOS 15, *)`）
	/// - `nonComplexAttributes` 簽名預設 `nil`：fork 自訂哪些 attribute 強制當 simple；`nil`/`[]` 等效不展開
	///
	/// 不提供 `varAttributes` 總控：swiftformat 0.54.0 起 `--var-attributes` 已拆分為
	/// `--stored-var-attributes` / `--computed-var-attributes`、umbrella 選項被 deprecated；
	/// stored / computed 已涵蓋所有 var、毋須再傳會觸發 deprecation warning 的 `--var-attributes`。
	case wrapAttributes(
		rule: Flag,
		funcAttributes: AttributeMode = .prevLine,
		typeAttributes: AttributeMode = .prevLine,
		storedVarAttributes: AttributeMode = .prevLine,
		computedVarAttributes: AttributeMode = .prevLine,
		complexAttributes: AttributeMode = .prevLine,
		nonComplexAttributes: [String]? = nil
	)

	/// 把 inline switch case body 換到下一行（`case .foo: return bar` → `case .foo:` + 換行縮排）
	case wrapCaseBodies(rule: Flag)

	/// 把逗號分隔的 enum case 拆成一行一個（`case bar, baz` → `case bar` + `case baz`）
	///
	/// `wrapEnumCases` 簽名預設 `.always`：所有逗號分隔 case 都拆（含 flat enum
	/// 如 `case up, down, left, right`）、跟上游預設一致、一致性最高。
	/// 設 `.withValues` 只拆有 associated value 的 case、保留簡單 case 緊湊寫法。
	case wrapEnumCases(rule: Flag, wrapEnumCases: WrapEnumCases = .always)

	/// 把 single-line function / init / subscript body 拆成多行（`func foo() { print("bar") }` → 多行寫法）
	case wrapFunctionBodies(rule: Flag)

	/// 把 inline `guard` body 換成多行（`guard let x = y else { return }` → 多行寫法）
	case wrapGuardStatementBodies(rule: Flag)

	/// 把 inline `if` expression body 換成多行（作為運算式的 `if`、Swift 5.9+ SE-0380）
	case wrapIfExpressionBodies(rule: Flag)

	/// 把 inline `if` statement body 換成多行（`if foo { return }` → 多行寫法）
	case wrapIfStatementBodies(rule: Flag)

	/// 把 single-line `for` / `while` loop body 拆成多行（`for x in arr { print(x) }` → 多行寫法）
	case wrapLoopBodies(rule: Flag)

	/// 把 multiline conditional assignment（Swift 5.9+ `if`/`switch` expression）的整個
	/// conditional block 換到 `=` 後下一行、縮排（`let x = if foo { ... }` → `let x =` + 換行）
	case wrapMultilineConditionalAssignment(rule: Flag)

	/// 已多行的 chained function call 強制每個 method 拆成獨立一行（all-or-nothing、
	/// 不允許 mixed layout）
	case wrapMultilineFunctionChains(rule: Flag)

	/// multi-line 條件式（`if`/`guard`/`while`）的 opening brace `{` 換到單獨一行
	case wrapMultilineStatementBraces(rule: Flag)

	/// 把 single-line property body 拆成多行（`var bar: String { "bar" }` → 多行寫法）
	case wrapPropertyBodies(rule: Flag)

	/// 把超過 `--max-width` 的 single-line `//` comment 自動拆成多行
	///
	/// 透過 sharedOptions 讀 `wrap` 規則的 `maxWidth`（SwiftStyleKit 設 120）。DocC inline
	/// code span ` `` ` 內的 token 不會被拆斷。
	case wrapSingleLineComments(rule: Flag)

	/// 把逗號分隔的 switch case pattern 拆成多行 + align（`case .bar, .baz:` →
	/// `case .bar,` + 換行 `     .baz:`）
	case wrapSwitchCases(rule: Flag)

	/// 把 yoda condition（常數在左側）翻成自然順序（`5 == foo` → `foo == 5`）
	///
	/// `mode` 簽名預設 `.always`（與上游一致）：翻所有 yoda condition；設 `.literalsOnly`
	/// 改為只翻字面值放左側的情形。
	case yodaConditions(rule: Flag, mode: YodaMode = .always)

	/// type 宣告邊界（開頭與結尾）的空白行政策
	///
	/// 對應 swiftformat 全域 option `type-blank-lines`——``blankLinesAtStartOfScope(rule:)``
	/// 與 ``blankLinesAtEndOfScope(rule:)`` 共讀它（見 swiftformat issue #1745）。無
	/// ``Flag``：option 不是規則、swiftformat 沒有 `--enable` / `--disable` 之分。
	/// `mode` 預設 `.preserve`（SwiftStyleKit 選用值）、展開成 `--typeBlankLines preserve`；
	/// 設為 `nil` 則不展開、由 swiftformat 取上游預設。
	case typeBlankLines(mode: TypeBlankLines? = .preserve)

	/// 字串 `\(...)` 內插值的換行政策
	///
	/// 對應 swiftformat 全域 option `wrap-string-interpolation`——同時被
	/// ``wrap(rule:maxWidth:noWrapOperators:assetLiterals:wrapTernary:)``
	// swiftlint:disable:next line_length
	/// 與 ``wrapArguments(rule:wrapArguments:wrapParameters:wrapCollections:wrapConditions:wrapTypeAliases:wrapEffects:wrapReturnType:closingParen:callSiteParen:allowPartialWrapping:)``
	/// 兩規則 own。無 ``Flag``——option 不是規則。`mode` 簽名預設 `.default`（與上游一致）、
	/// 展開成 `--wrapStringInterpolation default`；設為 `nil` 則不展開、由 swiftformat 取上游預設。
	case wrapStringInterpolation(mode: StringInterpolationWrapMode? = .default)

	/// 已棄用、改用 ``sortImports(rule:mode:)``
	///
	/// swiftformat 規則改名後保留的相容別名；call site 展開仍用舊 flag 名（swiftformat
	/// 自身會印 deprecation warning 並映射到新規則）。不入 ``allRules``。
	@available(*, deprecated, renamed: "sortImports")
	case sortedImports(rule: Flag, mode: ImportGrouping = .testableFirst)

	/// 已棄用、改用 ``sortSwitchCases(rule:)``
	@available(*, deprecated, renamed: "sortSwitchCases")
	case sortedSwitchCases(rule: Flag)

	/// 已棄用、改用 ``modifierOrder(rule:modifierOrder:)``
	@available(*, deprecated, renamed: "modifierOrder")
	case specifiers(rule: Flag, modifierOrder: String? = nil)

	/// 已棄用、改用 ``noForceTryInTests(rule:)``
	@available(*, deprecated, renamed: "noForceTryInTests")
	case throwingTests(rule: Flag)

	/// 已棄用、改用 ``redundantVariable(rule:)``
	@available(*, deprecated, renamed: "redundantVariable")
	case redundantProperty(rule: Flag)

	/// 已棄用：上游 0.62.0 起依語句類型拆成三條新規則、原規則標 deprecated
	///
	/// 改用 ``wrapIfStatementBodies(rule:)`` / ``wrapIfExpressionBodies(rule:)``
	/// / ``wrapGuardStatementBodies(rule:)``；展開仍用舊 flag 名（swiftformat 自身映射
	/// 到三條新規則並印 deprecation warning）。不入 ``allRules``。
	@available(*, deprecated, message: "改用 wrapIfStatementBodies / wrapIfExpressionBodies / wrapGuardStatementBodies")
	case wrapConditionalBodies(rule: Flag)

	/// 過渡載體：已遷移規則包進巢狀 ``Storage``；待全部遷完再把 FormatRule 轉成 struct、
	/// 載體改為 internal `storage` property、本 case 消失。
	case _storage(Storage) // swiftlint:disable:this identifier_name

	// MARK: Public

	/// 已遷移規則的後端聯集（逐條長大）；對外名與型別安全由 ``FormatRule`` 的 static func 工廠提供。
	///
	/// 過渡期為 public（因被 public 載體 ``_storage(_:)`` 引用）；最終 flip 成 struct 後改 internal。
	public enum Storage {

		/// 當設定的單字字首為大寫時轉換成全大寫，清單見 ``defaultAcronyms``
		case acronyms(rule: Flag, String = FormatRule.defaultAcronyms)

		/// 在 `switch` 內每個 `case` 後插入空白行
		case blankLineAfterSwitchCase(rule: Flag, mode: BlankLineAfterSwitchCaseMode? = nil)

		/// 偏好在 `if`、`guard`、`while` 條件式中使用逗號取代 `&&`
		case andOperator(rule: Flag)

		/// 偏好在 protocol 宣告中使用 `AnyObject` 取代 `class`
		case anyObjectProtocol(rule: Flag)

		/// 偏好使用 `@main` 取代 `@UIApplicationMain` 與 `@NSApplicationMain`
		case applicationMain(rule: Flag)

		/// 偏好 `assertionFailure` 與 `preconditionFailure` 取代判斷為 `false` 的測試
		case assertionFailures(rule: Flag)

		/// 在 `import` 區塊後插入空白行
		case blankLineAfterImports(rule: Flag)

		/// 偏好 `contains(where:)` 取代 `filter(_:).isEmpty`、`first(where:) != nil` 與 `range(of:) != nil`
		case preferContains(rule: Flag)

		/// 偏好 `first(where:)` 取代 `filter(_:).first`（含 lazy 鏈；`.last` / `.count` 不改寫）
		case preferFirstWhere(rule: Flag)

		/// 偏好 `flatMap { ... }` 取代 `map { ... }.reduce([], +)`（攤平串接 O(n²) → O(n)）
		///
		/// 只認 `reduce([], +)` 攤平形；`reduce(0, +)` 等加總形不改寫。
		case preferFlatMap(rule: Flag)

		/// 偏好 `min()` 取代 `sorted().first`（具名 `sorted(by:)` 形轉 `min(by:)`）
		///
		/// trailing closure 形（`sorted { ... }.first`）、`sorted(using:)` 與 `.last` 皆不改寫。
		case preferMinOverSorted(rule: Flag)

		/// 移除 SwiftUI 冗餘 `Group` 包裝、非 `body` 的 view 屬性自動補 `@ViewBuilder`
		///
		/// 帶 modifier 的 `Group`（如 `.font` / `.onAppear` 掛在 Group 上）語義不同、保留不動。
		case redundantSwiftUIGroup(rule: Flag)
	}
}

// swiftlint:enable type_body_length
