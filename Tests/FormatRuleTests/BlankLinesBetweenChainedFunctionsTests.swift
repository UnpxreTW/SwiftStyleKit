import SwiftStyleFormatCore
import Testing

@Suite("blankLinesBetweenChainedFunctions")
struct BlankLinesBetweenChainedFunctionsTests {

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
}
