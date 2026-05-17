import SwiftStyleFormatCore
import Testing

@Suite("environmentEntry")
struct EnvironmentEntryTests {

    @Test("environmentEntry .disable 返空陣列")
    func environmentEntryDisable() {
        let args = FormatRule.environmentEntry(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("environmentEntry .enable 展開 --enable environmentEntry")
    func environmentEntryEnable() {
        let args = FormatRule.environmentEntry(rule: .enable).cliArguments
        #expect(args == ["--enable", "environmentEntry"])
    }
}
