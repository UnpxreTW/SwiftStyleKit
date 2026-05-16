import Testing
import SwiftStyleFormatCore

@Suite("FormatRule reflection")
struct FormatRuleTests {

    @Test("allRules 不為空、enum 有 case 註冊")
    func allRulesNotEmpty() {
        #expect(!FormatRule.allRules.isEmpty)
    }

    @Test("acronyms .disable 返空陣列（Xcode 入口已注入 --disable all、不出冗餘 args）")
    func acronymsDisable() {
        let args = FormatRule.acronyms(rule: .disable).cliArguments
        #expect(args.isEmpty)
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

    @Test("andOperator .disable 返空陣列")
    func andOperatorDisable() {
        let args = FormatRule.andOperator(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("andOperator .enable 展開 --enable andOperator")
    func andOperatorEnable() {
        let args = FormatRule.andOperator(rule: .enable).cliArguments
        #expect(args == ["--enable", "andOperator"])
    }

    @Test("anyObjectProtocol .disable 返空陣列")
    func anyObjectProtocolDisable() {
        let args = FormatRule.anyObjectProtocol(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("anyObjectProtocol .enable 展開 --enable anyObjectProtocol")
    func anyObjectProtocolEnable() {
        let args = FormatRule.anyObjectProtocol(rule: .enable).cliArguments
        #expect(args == ["--enable", "anyObjectProtocol"])
    }

    @Test("applicationMain .disable 返空陣列")
    func applicationMainDisable() {
        let args = FormatRule.applicationMain(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("applicationMain .enable 展開 --enable applicationMain")
    func applicationMainEnable() {
        let args = FormatRule.applicationMain(rule: .enable).cliArguments
        #expect(args == ["--enable", "applicationMain"])
    }

    @Test("assertionFailures .disable 返空陣列")
    func assertionFailuresDisable() {
        let args = FormatRule.assertionFailures(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("assertionFailures .enable 展開 --enable assertionFailures")
    func assertionFailuresEnable() {
        let args = FormatRule.assertionFailures(rule: .enable).cliArguments
        #expect(args == ["--enable", "assertionFailures"])
    }

    @Test("blankLineAfterImports .disable 返空陣列")
    func blankLineAfterImportsDisable() {
        let args = FormatRule.blankLineAfterImports(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLineAfterImports .enable 展開 --enable blankLineAfterImports")
    func blankLineAfterImportsEnable() {
        let args = FormatRule.blankLineAfterImports(rule: .enable).cliArguments
        #expect(args == ["--enable", "blankLineAfterImports"])
    }

    @Test("blankLineAfterSwitchCase .disable（無 mode）返空陣列")
    func blankLineAfterSwitchCaseDisableNoMode() {
        let args = FormatRule.blankLineAfterSwitchCase(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLineAfterSwitchCase .disable + mode（mode 被忽略）返空陣列")
    func blankLineAfterSwitchCaseDisableWithMode() {
        let args = FormatRule.blankLineAfterSwitchCase(rule: .disable, mode: .always).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLineAfterSwitchCase .enable mode .multilineOnly 展開 --enable + flag multiline-only")
    func blankLineAfterSwitchCaseEnableMultilineOnly() {
        let args = FormatRule.blankLineAfterSwitchCase(rule: .enable, mode: .multilineOnly).cliArguments
        #expect(args == [
            "--enable", "blankLineAfterSwitchCase",
            "--blankLineAfterSwitchCase", "multiline-only"
        ])
    }

    @Test("blankLineAfterSwitchCase .enable mode .always 展開 --enable + flag always")
    func blankLineAfterSwitchCaseEnableAlways() {
        let args = FormatRule.blankLineAfterSwitchCase(rule: .enable, mode: .always).cliArguments
        #expect(args == [
            "--enable", "blankLineAfterSwitchCase",
            "--blankLineAfterSwitchCase", "always"
        ])
    }

    @Test("blankLineAfterSwitchCase .enable（mode nil 跳過、swiftformat 取上游預設）只展開 --enable")
    func blankLineAfterSwitchCaseEnableNoMode() {
        let args = FormatRule.blankLineAfterSwitchCase(rule: .enable).cliArguments
        #expect(args == ["--enable", "blankLineAfterSwitchCase"])
    }

    @Test("blankLinesAroundMark .disable 返空陣列")
    func blankLinesAroundMarkDisable() {
        let args = FormatRule.blankLinesAroundMark(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLinesAroundMark .disable + lineAfterMarks（option 被忽略）返空陣列")
    func blankLinesAroundMarkDisableWithOption() {
        let args = FormatRule.blankLinesAroundMark(rule: .disable, lineAfterMarks: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLinesAroundMark .enable（lineAfterMarks 預設 .enable）展開 --enable + --lineAfterMarks true")
    func blankLinesAroundMarkEnableDefault() {
        let args = FormatRule.blankLinesAroundMark(rule: .enable).cliArguments
        #expect(args == [
            "--enable", "blankLinesAroundMark",
            "--lineAfterMarks", "true"
        ])
    }

    @Test("blankLinesAroundMark .enable lineAfterMarks .disable 展開 --lineAfterMarks false")
    func blankLinesAroundMarkEnableLineAfterMarksDisable() {
        let args = FormatRule.blankLinesAroundMark(rule: .enable, lineAfterMarks: .disable).cliArguments
        #expect(args == [
            "--enable", "blankLinesAroundMark",
            "--lineAfterMarks", "false"
        ])
    }

    @Test("blankLinesAtEndOfScope .disable 返空陣列")
    func blankLinesAtEndOfScopeDisable() {
        let args = FormatRule.blankLinesAtEndOfScope(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLinesAtEndOfScope .enable 展開 --enable blankLinesAtEndOfScope")
    func blankLinesAtEndOfScopeEnable() {
        let args = FormatRule.blankLinesAtEndOfScope(rule: .enable).cliArguments
        #expect(args == ["--enable", "blankLinesAtEndOfScope"])
    }

    @Test("blankLinesAtStartOfScope .disable 返空陣列")
    func blankLinesAtStartOfScopeDisable() {
        let args = FormatRule.blankLinesAtStartOfScope(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLinesAtStartOfScope .enable 展開 --enable blankLinesAtStartOfScope")
    func blankLinesAtStartOfScopeEnable() {
        let args = FormatRule.blankLinesAtStartOfScope(rule: .enable).cliArguments
        #expect(args == ["--enable", "blankLinesAtStartOfScope"])
    }

    @Test("blankLinesBetweenChainedFunctions .disable 返空陣列")
    func blankLinesBetweenChainedFunctionsDisable() {
        let args = FormatRule.blankLinesBetweenChainedFunctions(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLinesBetweenChainedFunctions .enable 展開 --enable blankLinesBetweenChainedFunctions")
    func blankLinesBetweenChainedFunctionsEnable() {
        let args = FormatRule.blankLinesBetweenChainedFunctions(rule: .enable).cliArguments
        #expect(args == ["--enable", "blankLinesBetweenChainedFunctions"])
    }

    @Test("blankLinesBetweenImports .disable 返空陣列")
    func blankLinesBetweenImportsDisable() {
        let args = FormatRule.blankLinesBetweenImports(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLinesBetweenImports .enable 展開 --enable blankLinesBetweenImports")
    func blankLinesBetweenImportsEnable() {
        let args = FormatRule.blankLinesBetweenImports(rule: .enable).cliArguments
        #expect(args == ["--enable", "blankLinesBetweenImports"])
    }

    @Test("blankLinesBetweenScopes .disable 返空陣列")
    func blankLinesBetweenScopesDisable() {
        let args = FormatRule.blankLinesBetweenScopes(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("blankLinesBetweenScopes .enable 展開 --enable blankLinesBetweenScopes")
    func blankLinesBetweenScopesEnable() {
        let args = FormatRule.blankLinesBetweenScopes(rule: .enable).cliArguments
        #expect(args == ["--enable", "blankLinesBetweenScopes"])
    }

    @Test("typeBlankLines mode nil 不展開、返空陣列（由 swiftformat 取上游預設）")
    func typeBlankLinesNil() {
        let args = FormatRule.typeBlankLines(mode: nil).cliArguments
        #expect(args.isEmpty)
    }

    @Test("typeBlankLines mode .remove 展開 --typeBlankLines remove")
    func typeBlankLinesRemove() {
        let args = FormatRule.typeBlankLines(mode: .remove).cliArguments
        #expect(args == ["--typeBlankLines", "remove"])
    }

    @Test("typeBlankLines mode .insert 展開 --typeBlankLines insert")
    func typeBlankLinesInsert() {
        let args = FormatRule.typeBlankLines(mode: .insert).cliArguments
        #expect(args == ["--typeBlankLines", "insert"])
    }

    @Test("typeBlankLines mode .preserve 展開 --typeBlankLines preserve")
    func typeBlankLinesPreserve() {
        let args = FormatRule.typeBlankLines(mode: .preserve).cliArguments
        #expect(args == ["--typeBlankLines", "preserve"])
    }

    @Test("typeBlankLines 預設（mode 省略 → .preserve）展開 --typeBlankLines preserve")
    func typeBlankLinesDefault() {
        let args = FormatRule.typeBlankLines().cliArguments
        #expect(args == ["--typeBlankLines", "preserve"])
    }
}
