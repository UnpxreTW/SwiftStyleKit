/// type 宣告邊界（開頭與結尾）空白行的處理方式
///
/// 對應 swiftformat 的 `type-blank-lines` option。此 option 不專屬單一規則——
/// `blankLinesAtStartOfScope` 與 `blankLinesAtEndOfScope` 兩規則上游 `options:`
/// 都列了它、body 都讀 `formatter.options.typeBlankLines`，swiftformat 全域只有
/// 一個對應的 `OptionDescriptor`（見 swiftformat issue #1745）。SwiftStyleKit
/// 因此把它當全域 option 處理、由 ``GlobalOption/typeBlankLines(_:)`` 承載、
/// 不綁任一規則 case。
public enum TypeBlankLines: String, FormatRuleOption {

    /// 對應的 swiftformat CLI option flag 名稱
    public static let flagName = "typeBlankLines"

    /// 移除 type 宣告邊界的空白行（swiftformat 上游預設）
    case remove

    /// 在 type 宣告邊界插入空白行
    case insert

    /// 保留 type 宣告邊界既有的空白行
    case preserve
}
