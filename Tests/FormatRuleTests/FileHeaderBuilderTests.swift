import SwiftStyleFormatCore
import Testing

@Suite("FileHeaderBuilder")
struct FileHeaderBuilderTests {

    @Test("從標準 MIT 版權行抓出持有人")
    func copyrightHolderFromMIT() {
        let text = """
        MIT License

        Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)

        Permission is hereby granted, free of charge, ...
        """
        #expect(FileHeaderBuilder.copyrightHolder(in: text) == "Unpxre (GitHub: UnpxreTW)")
    }

    @Test("版權行用 © 符號也抓得到持有人")
    func copyrightHolderWithSymbol() {
        #expect(FileHeaderBuilder.copyrightHolder(in: "Copyright © 2020 Some Person") == "Some Person")
    }

    @Test("年份範圍的版權行抓得到持有人")
    func copyrightHolderWithYearRange() {
        #expect(FileHeaderBuilder.copyrightHolder(in: "Copyright (c) 2020-2024 Foo Bar") == "Foo Bar")
    }

    @Test("無版權行回 nil")
    func copyrightHolderMissing() {
        #expect(FileHeaderBuilder.copyrightHolder(in: "No copyright statement here.") == nil)
    }

    @Test("辨識 MIT 授權")
    func recognizeMIT() {
        let result = FileHeaderBuilder.recognizeLicense(in: "MIT License\n\nCopyright (c) 2026 X")
        #expect(result?.name == "MIT License")
        #expect(result?.spdxID == "MIT")
    }

    @Test("辨識 Apache-2.0 授權")
    func recognizeApache() {
        let result = FileHeaderBuilder.recognizeLicense(in: "Apache License\nVersion 2.0, January 2004\n")
        #expect(result?.spdxID == "Apache-2.0")
    }

    @Test("未知授權回 nil")
    func recognizeUnknown() {
        #expect(FileHeaderBuilder.recognizeLicense(in: "Some Custom License\n\nblah") == nil)
    }

    @Test("recognized 組出含授權名稱與 SPDX 的完整標頭")
    func headerRecognized() {
        let header = FileHeaderBuilder.header(
            targetName: "SwiftStyleFormatCore",
            license: .recognized(holder: "Unpxre (GitHub: UnpxreTW)", name: "MIT License", spdxID: "MIT")
        )
        #expect(header == [
            "",
            "SwiftStyleFormatCore",
            "",
            "Copyright (c) {created.year} Unpxre (GitHub: UnpxreTW)",
            "Licensed under the MIT License. See LICENSE for details.",
            "",
            "SPDX-License-Identifier: MIT"
        ].joined(separator: #"\n"#))
    }

    @Test("unrecognized 省去授權名稱與 SPDX 行")
    func headerUnrecognized() {
        let header = FileHeaderBuilder.header(targetName: "App", license: .unrecognized(holder: "Someone"))
        #expect(header == [
            "",
            "App",
            "",
            "Copyright (c) {created.year} Someone",
            "See LICENSE for details."
        ].joined(separator: #"\n"#))
    }

    @Test("missing 省去持有人、結尾留空註解行")
    func headerMissing() {
        let header = FileHeaderBuilder.header(targetName: "App", license: .missing)
        #expect(header == [
            "",
            "App",
            "",
            "Copyright (c) {created.year}",
            ""
        ].joined(separator: #"\n"#))
    }
}
