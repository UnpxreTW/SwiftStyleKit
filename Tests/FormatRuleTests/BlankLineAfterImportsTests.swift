import SwiftStyleFormatCore
import Testing

@Suite("blankLineAfterImports")
struct BlankLineAfterImportsTests {

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
}
