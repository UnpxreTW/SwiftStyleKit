import SwiftStyleFormatCore
import Testing

@Suite("blankLinesAtEndOfScope")
struct BlankLinesAtEndOfScopeTests {

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
}
