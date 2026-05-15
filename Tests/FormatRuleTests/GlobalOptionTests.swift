import Testing
import SwiftStyleFormatCore

@Suite("GlobalOption reflection")
struct GlobalOptionTests {

    @Test("typeBlankLines(.remove) 展開 --typeBlankLines remove")
    func typeBlankLinesRemove() {
        let args = GlobalOption.typeBlankLines(.remove).cliArguments
        #expect(args == ["--typeBlankLines", "remove"])
    }

    @Test("typeBlankLines(.insert) 展開 --typeBlankLines insert")
    func typeBlankLinesInsert() {
        let args = GlobalOption.typeBlankLines(.insert).cliArguments
        #expect(args == ["--typeBlankLines", "insert"])
    }

    @Test("typeBlankLines(.preserve) 展開 --typeBlankLines preserve")
    func typeBlankLinesPreserve() {
        let args = GlobalOption.typeBlankLines(.preserve).cliArguments
        #expect(args == ["--typeBlankLines", "preserve"])
    }

    @Test("globalOptions 不為空、全域 option 有註冊")
    func globalOptionsNotEmpty() {
        #expect(!FormatRule.globalOptions.isEmpty)
    }

    @Test("allToCommand 尾段併入全域 option 展開")
    func allToCommandIncludesGlobalOptions() {
        let globalArgs = FormatRule.globalOptions.flatMap { $0.cliArguments }
        #expect(!globalArgs.isEmpty)
        #expect(FormatRule.allToCommand.suffix(globalArgs.count) == ArraySlice(globalArgs))
    }
}
