/// swiftformat 的全域 option
///
/// 對應 swiftformat 中不專屬單一規則的 option——多條規則的 `options:` 或
/// `sharedOptions:` 共讀同一個 `OptionDescriptor`。這類 option 與規則啟用與否
/// 無關（無 ``FormatRule/Flag`` 開關、永遠展開），故獨立於 ``FormatRule`` 之外、
/// 由 ``FormatRule/globalOptions`` 清單管理。
public enum GlobalOption {

    /// type 宣告邊界（開頭與結尾）的空白行政策
    ///
    /// 對應 swiftformat 的 `type-blank-lines` option。`blankLinesAtStartOfScope`
    /// 與 `blankLinesAtEndOfScope` 兩規則共讀它，語意是「type 宣告空白行政策」、
    /// 不專屬 start / end 任一規則（見 swiftformat issue #1745）。
    case typeBlankLines(TypeBlankLines)
}

public extension GlobalOption {
    /// 將此全域 option 展開為 swiftformat CLI 參數
    var cliArguments: [String] { command }
}

private extension GlobalOption {
    /// 取得當前 case 的反射節點（label + value）
    var currentCase: (label: String?, value: Any) {
        Mirror(reflecting: self).children.first!
    }

    /// 反射展開出 CLI 參數
    ///
    /// 同 ``FormatRule`` 的 option 展開邏輯、但少 `Flag` 段：全域 option 無啟用
    /// 開關、永遠展開成 `--<flag> <value>`。case 帶單一 associated value，Swift
    /// 對未具名單值會收斂、`currentCase.value` 即為該 option 值本身。
    var command: [String] {
        let (label, value) = currentCase
        let option: String = switch value {
        case let value as any RawRepresentable<String>: value.rawValue
        case let value as Bool: value ? "true" : "false"
        case let value as Int: "\(value)"
        case let value as String: value
        default: ""
        }
        // flag 名取得順序：型別自宣告（FormatRuleOption）> case 名
        let flag: String
        if let ruleOption = value as? any FormatRuleOption {
            flag = type(of: ruleOption).flagName
        } else {
            flag = label ?? ""
        }
        return ["--\(flag)", option]
    }
}
