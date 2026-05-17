import SwiftStyleFormatCore
import Testing

@Suite("consecutiveSpaces")
struct ConsecutiveSpacesTests {

    @Test("consecutiveSpaces .disable 返空陣列")
    func consecutiveSpacesDisable() {
        let args = FormatRule.consecutiveSpaces(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("consecutiveSpaces .enable 展開 --enable consecutiveSpaces")
    func consecutiveSpacesEnable() {
        let args = FormatRule.consecutiveSpaces(rule: .enable).cliArguments
        #expect(args == ["--enable", "consecutiveSpaces"])
    }
}
