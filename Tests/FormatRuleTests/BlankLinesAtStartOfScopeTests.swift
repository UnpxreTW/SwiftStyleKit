import Testing
import SwiftStyleFormatCore

@Suite("blankLinesAtStartOfScope")
struct BlankLinesAtStartOfScopeTests {

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
}
