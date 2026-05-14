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

    @Test("andOperator .enable 展開 --enable andOperator")
    func andOperatorEnable() {
        let args = FormatRule.andOperator(rule: .enable).cliArguments
        #expect(args == ["--enable", "andOperator"])
    }

    @Test("andOperator .disable 返空陣列")
    func andOperatorDisable() {
        let args = FormatRule.andOperator(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("anyObjectProtocol .enable 展開 --enable anyObjectProtocol")
    func anyObjectProtocolEnable() {
        let args = FormatRule.anyObjectProtocol(rule: .enable).cliArguments
        #expect(args == ["--enable", "anyObjectProtocol"])
    }

    @Test("anyObjectProtocol .disable 返空陣列")
    func anyObjectProtocolDisable() {
        let args = FormatRule.anyObjectProtocol(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("applicationMain .enable 展開 --enable applicationMain")
    func applicationMainEnable() {
        let args = FormatRule.applicationMain(rule: .enable).cliArguments
        #expect(args == ["--enable", "applicationMain"])
    }

    @Test("applicationMain .disable 返空陣列")
    func applicationMainDisable() {
        let args = FormatRule.applicationMain(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("assertionFailures .enable 展開 --enable assertionFailures")
    func assertionFailuresEnable() {
        let args = FormatRule.assertionFailures(rule: .enable).cliArguments
        #expect(args == ["--enable", "assertionFailures"])
    }

    @Test("assertionFailures .disable 返空陣列")
    func assertionFailuresDisable() {
        let args = FormatRule.assertionFailures(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLineAfterImports .enable 展開 --enable blankLineAfterImports")
    func blankLineAfterImportsEnable() {
        let args = FormatRule.blankLineAfterImports(rule: .enable).cliArguments
        #expect(args == ["--enable", "blankLineAfterImports"])
    }

    @Test("blankLineAfterImports .disable 返空陣列")
    func blankLineAfterImportsDisable() {
        let args = FormatRule.blankLineAfterImports(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }
}
