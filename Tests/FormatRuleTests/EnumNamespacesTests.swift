import SwiftStyleFormatCore
import Testing

@Suite("enumNamespaces")
struct EnumNamespacesTests {

    @Test("enumNamespaces .disable 返空陣列")
    func enumNamespacesDisable() {
        let args = FormatRule.enumNamespaces(rule: .disable).cliArguments
        #expect(args.isEmpty)
    }

    @Test("enumNamespaces .disable + mode（option 被忽略）返空陣列")
    func enumNamespacesDisableWithMode() {
        let args = FormatRule.enumNamespaces(rule: .disable, mode: .structsOnly).cliArguments
        #expect(args.isEmpty)
    }

    @Test("enumNamespaces .enable（mode 預設 .always）展開 --enable + --enumNamespaces always")
    func enumNamespacesEnableDefault() {
        let args = FormatRule.enumNamespaces(rule: .enable).cliArguments
        #expect(args == [
            "--enable", "enumNamespaces",
            "--enumNamespaces", "always"
        ])
    }

    @Test("enumNamespaces .enable mode .structsOnly 展開 --enumNamespaces structs-only")
    func enumNamespacesEnableStructsOnly() {
        let args = FormatRule.enumNamespaces(rule: .enable, mode: .structsOnly).cliArguments
        #expect(args == [
            "--enable", "enumNamespaces",
            "--enumNamespaces", "structs-only"
        ])
    }
}
