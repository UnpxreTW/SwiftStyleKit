import SwiftStyleFormatCore
import Testing

@Suite("FormatRule")
struct FormatRuleTests {

    @Test("allRules 不為空、enum 有 case 註冊")
    func allRulesNotEmpty() {
        #expect(!FormatRule.allRules.isEmpty)
    }
}
