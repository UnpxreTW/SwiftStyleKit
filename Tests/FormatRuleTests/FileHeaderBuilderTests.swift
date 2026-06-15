//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

// REUSE-IgnoreStart — 測試 fixture 含 MPL-2.0 / Apache-2.0 等檔頭樣本字串，
// 屬測試資料、非本檔（MIT，見上方檔頭）的授權宣告；不圈會讓 reuse lint
// 誤判 repo 使用多種授權、要求 LICENSES/ 補對應全文。

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
	private func `recognized MPL 無 author 但有 licenseHolder：退回 licenseHolder 一行`() {
		let header = FileHeaderBuilder.header(
			targetName: "koine",
			licenseHolder: "Unpxre (GitHub: UnpxreTW)",
			noticeHolder: nil,
			authors: [],
			license: .recognized(name: "Mozilla Public License 2.0", spdxID: "MPL-2.0")
		)
		#expect(header == [
			"",
			" koine",
			"",
			" SPDX-FileCopyrightText: {created.year} Unpxre (GitHub: UnpxreTW)",
			" SPDX-License-Identifier: MPL-2.0"
		].joined(separator: #"\n"#))
	}

	@Test
	private func `recognized MPL 無任何 holder：header() 退化只剩 SPDX（plugin 端 gate 擋下）`() {
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
	private func `recognized Apache 無 NOTICE：退回 licenseHolder`() {
		let header = FileHeaderBuilder.header(
			targetName: "App",
			licenseHolder: "Unpxre (GitHub: UnpxreTW)",
			noticeHolder: nil,
			authors: [],
			license: .recognized(name: "Apache License 2.0", spdxID: "Apache-2.0")
		)
		#expect(header == [
			"",
			" App",
			"",
			" Copyright © {created.year} Unpxre (GitHub: UnpxreTW)",
			" Licensed under the Apache License 2.0. See LICENSE for details.",
			"",
			" SPDX-License-Identifier: Apache-2.0"
		].joined(separator: #"\n"#))
	}

	@Test
	private func `recognized FSL：LICENSE holder 缺席時 fallback AUTHORS 各一行 Copyright`() {
		let header = FileHeaderBuilder.header(
			targetName: "Koine",
			licenseHolder: nil,
			noticeHolder: "不該用我",
			authors: ["Unpxre (GitHub: UnpxreTW)", "Alice Chen"],
			license: .recognized(name: "Functional Source License 1.1", spdxID: "FSL-1.1-ALv2")
		)
		#expect(header == [
			"",
			" Koine",
			"",
			" Copyright © {created.year} Unpxre (GitHub: UnpxreTW)",
			" Copyright © {created.year} Alice Chen",
			" Licensed under the Functional Source License 1.1. See LICENSE for details.",
			"",
			" SPDX-License-Identifier: FSL-1.1-ALv2"
		].joined(separator: #"\n"#))
	}

	@Test
	private func `recognized FSL：LICENSE holder 在場時不用 AUTHORS`() {
		let header = FileHeaderBuilder.header(
			targetName: "Koine",
			licenseHolder: "Unpxre (GitHub: UnpxreTW)",
			noticeHolder: nil,
			authors: ["忽略我"],
			license: .recognized(name: "Functional Source License 1.1", spdxID: "FSL-1.1-MIT")
		)
		#expect(header == [
			"",
			" Koine",
			"",
			" Copyright © {created.year} Unpxre (GitHub: UnpxreTW)",
			" Licensed under the Functional Source License 1.1. See LICENSE for details.",
			"",
			" SPDX-License-Identifier: FSL-1.1-MIT"
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

@Suite("FileHeaderBuilder GNU")
private struct FileHeaderBuilderGNUTests {

	@Test
	private func `recognized GPL：Copyright © 用 NOTICE holder（不取 LICENSE 的 FSF 版權）`() {
		let header = FileHeaderBuilder.header(
			targetName: "App",
			licenseHolder: "Free Software Foundation, Inc.",
			noticeHolder: "The Foo Project",
			authors: [],
			license: .recognized(name: "GNU General Public License v3.0", spdxID: "GPL-3.0-only")
		)
		#expect(header == [
			"",
			" App",
			"",
			" Copyright © {created.year} The Foo Project",
			" Licensed under the GNU General Public License v3.0. See LICENSE for details.",
			"",
			" SPDX-License-Identifier: GPL-3.0-only"
		].joined(separator: #"\n"#))
	}

	@Test
	private func `recognized GPL 無 NOTICE：fallback AUTHORS 各一行 Copyright`() {
		let header = FileHeaderBuilder.header(
			targetName: "App",
			licenseHolder: "Free Software Foundation, Inc.",
			noticeHolder: nil,
			authors: ["Unpxre (GitHub: UnpxreTW)", "Alice Chen"],
			license: .recognized(name: "GNU General Public License v3.0", spdxID: "GPL-3.0-only")
		)
		#expect(header == [
			"",
			" App",
			"",
			" Copyright © {created.year} Unpxre (GitHub: UnpxreTW)",
			" Copyright © {created.year} Alice Chen",
			" Licensed under the GNU General Public License v3.0. See LICENSE for details.",
			"",
			" SPDX-License-Identifier: GPL-3.0-only"
		].joined(separator: #"\n"#))
	}
}

// REUSE-IgnoreEnd
