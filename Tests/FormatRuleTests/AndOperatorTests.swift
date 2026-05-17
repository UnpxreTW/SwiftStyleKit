import SwiftStyleFormatCore
import Testing

@Suite("andOperator")
struct AndOperatorTests {

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
}
