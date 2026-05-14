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
                command.append(contentsOf: ["--\(ruleFlag)", name])
                guard case .enable = ruleFlag else { break }
                continue
            }

            let option: String = switch unwrapped {
            case let value as any RawRepresentable<String>: value.rawValue
            case let value as Bool: value ? "true" : "false"
            case let value as Int: "\(value)"
            case let value as String: value
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
