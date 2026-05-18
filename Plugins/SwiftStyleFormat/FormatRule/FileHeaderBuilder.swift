import Foundation

/// 檔案標頭組裝
///
/// 由 plugin 在執行期呼叫——`copyrightHolder` 與 `recognizeLicense` 解析使用端專案的
/// `LICENSE`，`header` 依結果組出傳給 swiftformat `--header` 的標頭字串。
public enum FileHeaderBuilder {

    /// `LICENSE` 檔的辨識結果
    public enum LicenseInfo {

        /// 無 `LICENSE` 檔
        case missing

        /// 有 `LICENSE` 檔、但授權類型未辨識
        case unrecognized(holder: String?)

        /// 有 `LICENSE` 檔、授權類型已辨識
        case recognized(holder: String?, name: String, spdxID: String)
    }

    /// 從 `LICENSE` 內容抓版權持有人
    ///
    /// 比對 `Copyright (©|(c)) <年份> <持有人>` 形式的版權行、取「持有人」段；找不到回 `nil`。
    public static func copyrightHolder(in licenseText: String) -> String? {
        let pattern = #"(?im)^\s*copyright\s+(?:\([cC]\)\s+|©\s+)?\d{4}(?:\s*[-–]\s*\d{4})?\s+(.+?)\s*$"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        let range = NSRange(licenseText.startIndex..., in: licenseText)
        guard
            let match = regex.firstMatch(in: licenseText, range: range),
            let holderRange = Range(match.range(at: 1), in: licenseText)
        else {
            return nil
        }
        let holder = String(licenseText[holderRange]).trimmingCharacters(in: .whitespaces)
        return holder.isEmpty ? nil : holder
    }

    /// 以 `LICENSE` 首行標題辨識授權
    ///
    /// 比對常見授權的標題，回傳人類可讀名稱與 SPDX 識別碼；辨識不到回 `nil`。
    public static func recognizeLicense(in licenseText: String) -> (name: String, spdxID: String)? {
        let firstLine = licenseText
            .split(whereSeparator: { $0.isNewline })
            .map { String($0).trimmingCharacters(in: .whitespaces) }
            .first { !$0.isEmpty }?
            .lowercased()
        guard let firstLine else { return nil }
        for (prefix, license) in licenseTable where firstLine.hasPrefix(prefix) {
            return license
        }
        return nil
    }

    /// 依 target 名與 `LICENSE` 辨識結果組裝標頭字串
    ///
    /// 回傳值以字面 `\n` 分隔行、供 swiftformat `--header` 使用。`{created.year}` 維持
    /// token 形式、由 swiftformat 執行時解析。
    public static func header(targetName: String, license: LicenseInfo) -> String {
        var lines = ["", targetName, ""]
        switch license {
        case .missing:
            lines.append(copyrightLine(holder: nil))
            lines.append("")
        case let .unrecognized(holder):
            lines.append(copyrightLine(holder: holder))
            lines.append("See LICENSE for details.")
        case let .recognized(holder, name, spdxID):
            lines.append(copyrightLine(holder: holder))
            lines.append("Licensed under the \(name). See LICENSE for details.")
            lines.append("")
            lines.append("SPDX-License-Identifier: \(spdxID)")
        }
        return lines.joined(separator: #"\n"#)
    }

    /// 常見授權的首行標題（小寫）對照表
    private static let licenseTable: [String: (name: String, spdxID: String)] = [
        "mit license": ("MIT License", "MIT"),
        "apache license": ("Apache License 2.0", "Apache-2.0"),
        "bsd 2-clause license": ("BSD 2-Clause License", "BSD-2-Clause"),
        "bsd 3-clause license": ("BSD 3-Clause License", "BSD-3-Clause"),
        "isc license": ("ISC License", "ISC"),
        "mozilla public license version 2.0": ("Mozilla Public License 2.0", "MPL-2.0")
    ]

    /// 組版權行——有持有人則附上、否則只到年份
    private static func copyrightLine(holder: String?) -> String {
        if let holder {
            "Copyright (c) {created.year} \(holder)"
        } else {
            "Copyright (c) {created.year}"
        }
    }
}
