/// 格式規則
///
/// 每個 case 對應 swiftformat 一條 rule，Mirror reflection 自動展開為 CLI 參數。
public enum FormatRule {

    /// 當設定的單字字首為大寫時轉換成全大寫，清單見 ``defaultAcronyms``
    case acronyms(rule: Flag, String = FormatRule.defaultAcronyms)

    /// 偏好在 `if`、`guard`、`while` 條件式中使用逗號取代 `&&`
    case andOperator(rule: Flag)
}

public extension FormatRule {
    /// 將此 rule 展開為 swiftformat CLI 參數
    var arguments: [String] { command }
}

private extension FormatRule {
    /// 取得當前 case 的反射節點（label + value）
    ///
    /// - note: 當前使用反射取得其內容
    var currentCase: (label: String?, value: Any) {
        Mirror(reflecting: self).children.first!
    }

    /// 當前 case 的名稱
    var name: String { currentCase.label! }

    /// 反射展開出 CLI 參數
    var command: [String] {
        var command: [String] = []
        for (label, option) in Mirror(reflecting: currentCase.value).children {
            if let ruleFlag = option as? Flag {
                command.append(contentsOf: ["--\(ruleFlag)", name])
                guard case .enable = ruleFlag else { break }
                continue
            }
            let option: String = switch option {
            case let option as Option: String(describing: option)
            case let option as Bool: option ? "true" : "false"
            case let option as Int: "\(option)"
            case let option as String: option
            default: ""
            }
            if let label, !label.isEmpty, label.first != "." {
                command.append(contentsOf: ["--\(label)", option])
            } else {
                // unnamed associated value：用 case 名稱當 option key
                command.append(contentsOf: ["--\(name)", option])
            }
        }
        return command
    }
}

public extension FormatRule {
    /// 此 package 啟用的規則集合
    static var allRules: [Self] = [
        .acronyms(rule: .enable),
        .andOperator(rule: .enable)
    ]

    /// 全部啟用規則展開成 swiftformat CLI 參數
    static var allToCommand: [String] { allRules.flatMap { $0.command } }
}

public extension FormatRule {
    /// 用於描述啟用與否的旗標，其包含是否啟用、用途與轉換格式
    ///
    /// - Important: 當參數列表包含此型態的參數且為不啟用時會直接關閉對應的規則
    struct Option: OptionSet {

        public static let disable: Option = .init(rawValue: 0)

        public static let enable: Option = .init(rawValue: 1)

        /// 轉換為 "true" 或 "false" 字串
        public static let convertToTrueOrFlase: Self = .init(rawValue: 1 << 2)

        public var rawValue: Int

        private var _custom: String = ""

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public init(rawValue: Int, with custom: String) {
            self.init(rawValue: rawValue)
            self._custom = custom
        }
    }
}

extension FormatRule.Option: CustomStringConvertible {

    public var description: String {
        if self.contains(.convertToTrueOrFlase) {
            self.contains(.enable) ? "true" : "false"
        } else {
            ""
        }
    }
}
