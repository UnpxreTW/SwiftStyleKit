import SwiftStyleFormatCore
import Testing

@Suite("FileHeaderBuilder")
struct FileHeaderBuilderTests {

    @Test("標準 (c) 版權行抓出持有人")
    func copyrightHolderStandard() {
        let holder = FileHeaderBuilder.copyrightHolder(in: "Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)")
        #expect(holder == "Unpxre (GitHub: UnpxreTW)")
    }

    @Test("© 符號版權行抓得到持有人")
    func copyrightHolderWithSymbol() {
        #expect(FileHeaderBuilder.copyrightHolder(in: "Copyright © 2020 Some Person") == "Some Person")
    }

    @Test("年份範圍版權行抓得到持有人")
    func copyrightHolderWithYearRange() {
        #expect(FileHeaderBuilder.copyrightHolder(in: "Copyright (c) 2014-2022 Foo Bar") == "Foo Bar")
    }

    @Test("年份接 Present 抓得到持有人")
    func copyrightHolderWithPresent() {
        #expect(FileHeaderBuilder.copyrightHolder(in: "Copyright (c) 2011-Present SnapKit Team") == "SnapKit Team")
    }

    @Test("前導 markdown 粗體不影響抓持有人")
    func copyrightHolderWithMarkdown() {
        #expect(FileHeaderBuilder.copyrightHolder(in: "**Copyright © 2015 Krunoslav Zaher**") == "Krunoslav Zaher")
    }

    @Test("剝除尾端 All rights reserved")
    func copyrightHolderStripsReserved() {
        let text = "Copyright 2014 The Flutter Authors. All rights reserved."
        #expect(FileHeaderBuilder.copyrightHolder(in: text) == "The Flutter Authors")
    }

    @Test("無版權行回 nil")
    func copyrightHolderMissing() {
        #expect(FileHeaderBuilder.copyrightHolder(in: "No copyright statement here.") == nil)
    }

    @Test("辨識 MIT——不依賴標題行")
    func recognizeMIT() {
        let text = "Copyright (c) 2026 X\n\nPermission is hereby granted, free of charge, to any person."
        let result = FileHeaderBuilder.recognizeLicense(in: text)
        #expect(result?.name == "MIT License")
        #expect(result?.spdxID == "MIT")
    }

    @Test("辨識 Apache-2.0")
    func recognizeApache() {
        let result = FileHeaderBuilder.recognizeLicense(in: "Apache License\nVersion 2.0, January 2004")
        #expect(result?.spdxID == "Apache-2.0")
    }

    @Test("辨識 BSD-3-Clause——靠第三條款語句")
    func recognizeBSD3() {
        let text = """
        Redistribution and use in source and binary forms are permitted.
        Neither the name of the copyright holder may be used to endorse products.
        """
        #expect(FileHeaderBuilder.recognizeLicense(in: text)?.spdxID == "BSD-3-Clause")
    }

    @Test("辨識 MPL-2.0")
    func recognizeMPL() {
        let result = FileHeaderBuilder.recognizeLicense(in: "Mozilla Public License Version 2.0")
        #expect(result?.spdxID == "MPL-2.0")
    }

    @Test("未知授權回 nil")
    func recognizeUnknown() {
        #expect(FileHeaderBuilder.recognizeLicense(in: "Some Custom License\n\nDo whatever you want.") == nil)
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
