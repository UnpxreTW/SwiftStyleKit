import SwiftStyleFormatCore
import Testing

@Suite("fileHeader")
struct FileHeaderTests {

    @Test("fileHeader .disable 返空陣列")
    func fileHeaderDisable() {
        let args = FormatRule.fileHeader(
            rule: .disable,
            header: "ignore",
            dateFormat: "system",
            timeZone: "system"
        ).cliArguments
        #expect(args.isEmpty)
    }

    @Test("fileHeader .enable 展開 --enable + header / dateFormat / timeZone")
    func fileHeaderEnable() {
        let args = FormatRule.fileHeader(
            rule: .enable,
            header: "// {file}",
            dateFormat: "iso",
            timeZone: "utc"
        ).cliArguments
        #expect(args == [
            "--enable", "fileHeader",
            "--header", "// {file}",
            "--dateFormat", "iso",
            "--timeZone", "utc"
        ])
    }
}
