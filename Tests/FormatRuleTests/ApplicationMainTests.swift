import Testing
import SwiftStyleFormatCore

@Suite("applicationMain")
struct ApplicationMainTests {

    @Test("applicationMain .disable 返空陣列")
    func applicationMainDisable() {
        let args = FormatRule.applicationMain(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("applicationMain .enable 展開 --enable applicationMain")
    func applicationMainEnable() {
        let args = FormatRule.applicationMain(rule: .enable).cliArguments
        #expect(args == ["--enable", "applicationMain"])
    }
}
