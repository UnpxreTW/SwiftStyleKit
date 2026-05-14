import Testing
import SwiftStyleFormatCore

@Suite("FormatRule reflection")
struct FormatRuleTests {

    @Test("allRules 不為空、enum 有 case 註冊")
    func allRulesNotEmpty() {
        #expect(!FormatRule.allRules.isEmpty)
    }

    @Test("acronyms .enable 展開 --enable acronyms 並帶 --acronyms 預設清單")
    func acronymsEnable() {
        let args = FormatRule.acronyms(rule: .enable).cliArguments
        #expect(args.count == 4)
        #expect(args[0] == "--enable")
        #expect(args[1] == "acronyms")
        #expect(args[2] == "--acronyms")
        #expect(!args[3].isEmpty)
        #expect(args[3].contains("URL"))
    }

    @Test("acronyms .disable 返空陣列（Xcode 入口已注入 --disable all、不出冗餘 args）")
    func acronymsDisable() {
        let args = FormatRule.acronyms(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }
}
