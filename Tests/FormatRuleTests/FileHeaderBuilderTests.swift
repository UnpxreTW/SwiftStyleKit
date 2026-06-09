//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

// swiftformat:disable propertyTypes
// 原因：FileHeaderBuilder 為 caseless enum、`Type.staticMethod()` call 形式繞過
// propertyTypes 規則 `.explicit` 模式對「Type.method() 假設回 Type」的判斷——`copyrightHolder`
// 回 String?、`recognizeLicense` 回 tuple? 、`header` 回 String，自洗會插錯標註

@Suite("FileHeaderBuilder")
private struct FileHeaderBuilderTests {

	@Test
	// swiftlint:disable:next identifier_name
	private func `標準 (c) 版權行抓出持有人`() {
		let holder = FileHeaderBuilder.copyrightHolder(in: "Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)")
		#expect(holder == "Unpxre (GitHub: UnpxreTW)")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `© 符號版權行抓得到持有人`() {
		#expect(FileHeaderBuilder.copyrightHolder(in: "Copyright © 2020 Some Person") == "Some Person")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func 年份範圍版權行抓得到持有人() {
		#expect(FileHeaderBuilder.copyrightHolder(in: "Copyright (c) 2014-2022 Foo Bar") == "Foo Bar")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `年份接 Present 抓得到持有人`() {
		#expect(FileHeaderBuilder.copyrightHolder(in: "Copyright (c) 2011-Present SnapKit Team") == "SnapKit Team")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `前導 markdown 粗體不影響抓持有人`() {
		#expect(FileHeaderBuilder.copyrightHolder(in: "**Copyright © 2015 Krunoslav Zaher**") == "Krunoslav Zaher")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `剝除尾端 All rights reserved`() {
		let text = "Copyright 2014 The Flutter Authors. All rights reserved."
		#expect(FileHeaderBuilder.copyrightHolder(in: text) == "The Flutter Authors")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `無版權行回 nil`() {
		#expect(FileHeaderBuilder.copyrightHolder(in: "No copyright statement here.") == nil)
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `辨識 MIT——不依賴標題行`() {
		let text = "Copyright (c) 2026 X\n\nPermission is hereby granted, free of charge, to any person."
		let result = FileHeaderBuilder.recognizeLicense(in: text)
		#expect(result?.name == "MIT License")
		#expect(result?.spdxID == "MIT")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `辨識 Apache-2.0`() {
		let result = FileHeaderBuilder.recognizeLicense(in: "Apache License\nVersion 2.0, January 2004")
		#expect(result?.spdxID == "Apache-2.0")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `辨識 BSD-3-Clause——靠第三條款語句`() {
		let text = """
			Redistribution and use in source and binary forms are permitted.
			Neither the name of the copyright holder may be used to endorse products.
			"""
		#expect(FileHeaderBuilder.recognizeLicense(in: text)?.spdxID == "BSD-3-Clause")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `辨識 MPL-2.0`() {
		let result = FileHeaderBuilder.recognizeLicense(in: "Mozilla Public License Version 2.0")
		#expect(result?.spdxID == "MPL-2.0")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `未知授權回 nil`() {
		#expect(FileHeaderBuilder.recognizeLicense(in: "Some Custom License\n\nDo whatever you want.") == nil)
	}

	@Test
	private func `recognized MIT：Copyright © 用 LICENSE holder、原樣格式`() {
		let header = FileHeaderBuilder.header(
			targetName: "SwiftStyleFormatCore",
			licenseHolder: "Unpxre (GitHub: UnpxreTW)",
			noticeHolder: nil,
			authors: ["忽略我"],
			license: .recognized(name: "MIT License", spdxID: "MIT")
		)
		#expect(header == [
			"",
			" SwiftStyleFormatCore",
			"",
			" Copyright © {created.year} Unpxre (GitHub: UnpxreTW)",
			" Licensed under the MIT License. See LICENSE for details.",
			"",
			" SPDX-License-Identifier: MIT"
		].joined(separator: #"\n"#))
	}

	@Test
	private func `recognized MPL：每位 author 各一行 SPDX-FileCopyrightText`() {
		let header = FileHeaderBuilder.header(
			targetName: "koine",
			licenseHolder: nil,
			noticeHolder: nil,
			authors: ["Unpxre (GitHub: UnpxreTW)", "Alice Chen"],
			license: .recognized(name: "Mozilla Public License 2.0", spdxID: "MPL-2.0")
		)
		#expect(header == [
			"",
			" koine",
			"",
			" SPDX-FileCopyrightText: {created.year} Unpxre (GitHub: UnpxreTW)",
			" SPDX-FileCopyrightText: {created.year} Alice Chen",
			" SPDX-License-Identifier: MPL-2.0"
		].joined(separator: #"\n"#))
	}

	@Test
	private func `recognized MPL 無 author：省略 copyright、只剩 SPDX-License-Identifier`() {
		let header = FileHeaderBuilder.header(
			targetName: "koine",
			licenseHolder: nil,
			noticeHolder: nil,
			authors: [],
			license: .recognized(name: "Mozilla Public License 2.0", spdxID: "MPL-2.0")
		)
		#expect(header == [
			"",
			" koine",
			"",
			" SPDX-License-Identifier: MPL-2.0"
		].joined(separator: #"\n"#))
	}

	@Test
	private func `recognized Apache：Copyright © 用 NOTICE holder`() {
		let header = FileHeaderBuilder.header(
			targetName: "App",
			licenseHolder: "不該用我",
			noticeHolder: "The Foo Project",
			authors: [],
			license: .recognized(name: "Apache License 2.0", spdxID: "Apache-2.0")
		)
		#expect(header == [
			"",
			" App",
			"",
			" Copyright © {created.year} The Foo Project",
			" Licensed under the Apache License 2.0. See LICENSE for details.",
			"",
			" SPDX-License-Identifier: Apache-2.0"
		].joined(separator: #"\n"#))
	}

	@Test
	private func `unrecognized：Copyright © 用 LICENSE holder + See LICENSE`() {
		let header = FileHeaderBuilder.header(
			targetName: "App",
			licenseHolder: "Someone",
			noticeHolder: nil,
			authors: [],
			license: .unrecognized
		)
		#expect(header == [
			"",
			" App",
			"",
			" Copyright © {created.year} Someone",
			" See LICENSE for details."
		].joined(separator: #"\n"#))
	}

	@Test
	private func `missing：Copyright © 無 holder`() {
		let header = FileHeaderBuilder.header(
			targetName: "App",
			licenseHolder: nil,
			noticeHolder: nil,
			authors: [],
			license: .missing
		)
		#expect(header == [
			"",
			" App",
			"",
			" Copyright © {created.year}",
			""
		].joined(separator: #"\n"#))
	}

	@Test
	private func `authors 取非空非註解行、依序`() {
		let parsed = FileHeaderBuilder.authors(in: "Unpxre (GitHub: UnpxreTW)\n\n# 個別貢獻者\n# Alice\nBob Wang")
		#expect(parsed == ["Unpxre (GitHub: UnpxreTW)", "Bob Wang"])
	}
}
