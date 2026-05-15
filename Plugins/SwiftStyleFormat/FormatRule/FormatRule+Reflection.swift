public extension FormatRule {
    /// 將此 rule 展開為 swiftformat CLI 參數
    var cliArguments: [String] { command }
}

private extension FormatRule {
    /// 取得當前 case 的反射節點（label + value）
    var currentCase: (label: String?, value: Any) {
        Mirror(reflecting: self).children.first!
    }

    /// 當前 case 的名稱
    var name: String { currentCase.label! }

    /// 反射展開出 CLI 參數
    var command: [String] {
        var command: [String] = []
        for (label, raw) in Mirror(reflecting: currentCase.value).children {
            // Optional unwrap：nil 跳過、some 取 inner value（讓 case 簽名可帶 Optional option）
            let unwrapped: Any
            let optionalMirror = Mirror(reflecting: raw)
            if optionalMirror.displayStyle == .optional {
                guard let first = optionalMirror.children.first else { continue }
                unwrapped = first.value
            } else {
                unwrapped = raw
            }

            if let ruleFlag = unwrapped as? Flag {
                // .disable case 整個不展開：Xcode 入口已注入 `--disable all`、後面
                // 再加 `--disable <name>` 是冗餘的 CLI 雜訊。改為 .disable 返空陣列、
                // 只有 .enable 才 append `--enable <name>` 與後續 option 展開
                guard case .enable = ruleFlag else { return [] }
                command.append(contentsOf: ["--\(ruleFlag)", name])
                continue
            }

            let option: String = switch unwrapped {
            case let value as any RawRepresentable<String>: value.rawValue
            case let value as Bool: value ? "true" : "false"
            case let value as Int: "\(value)"
            case let value as String: value
            default: ""
            }
            // option flag 名取得順序：型別自宣告（FormatRuleOption）> Swift label
            // > case 名。讓 case 簽名的參數 label 可取人類可讀名（如 `mode:`），
            // 與 swiftformat flag 名（如 `--blankLineAfterSwitchCase`）解耦
            let flag: String
            if let ruleOption = unwrapped as? any FormatRuleOption {
                flag = type(of: ruleOption).flagName
            } else if let label, !label.isEmpty, label.first != "." {
                flag = label
            } else {
                // unnamed associated value：用 case 名稱當 option key
                flag = name
            }
            command.append(contentsOf: ["--\(flag)", option])
        }
        return command
    }
}
