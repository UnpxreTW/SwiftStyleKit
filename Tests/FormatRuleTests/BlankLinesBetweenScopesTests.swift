import SwiftStyleFormatCore
import Testing

@Suite("blankLinesBetweenScopes")
struct BlankLinesBetweenScopesTests {

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
}
