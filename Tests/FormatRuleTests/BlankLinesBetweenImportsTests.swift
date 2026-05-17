import Testing
import SwiftStyleFormatCore

@Suite("blankLinesBetweenImports")
struct BlankLinesBetweenImportsTests {

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
}
