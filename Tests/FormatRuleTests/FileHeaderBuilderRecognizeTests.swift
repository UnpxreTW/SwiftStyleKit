//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

// REUSE-IgnoreStart — 測試 fixture 含 MPL-2.0 / Apache-2.0 / FSL / GNU 等授權樣本字串，
// 屬測試資料、非本檔（MIT，見上方檔頭）的授權宣告；不圈會讓 reuse lint
// 誤判 repo 使用多種授權、要求 LICENSES/ 補對應全文。

// swiftformat:disable propertyTypes
// 原因：FileHeaderBuilder 為 caseless enum、`Type.staticMethod()` call 形式繞過
// propertyTypes 規則 `.explicit` 模式對「Type.method() 假設回 Type」的判斷——
// `recognizeLicense` 回 tuple?，自洗會插錯標註

@Suite("FileHeaderBuilder 授權辨識")
private struct FileHeaderBuilderRecognizeTests {

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
	private func `辨識 BSD-2-Clause——無 neither the name 條款`() {
		let text = """
			Redistribution and use in source and binary forms, with or without modification, are permitted.
			Redistributions of source code must retain the above copyright notice.
			"""
		#expect(FileHeaderBuilder.recognizeLicense(in: text)?.spdxID == "BSD-2-Clause")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `辨識 ISC——permission to use copy modify and/or distribute`() {
		let text = "Permission to use, copy, modify, and/or distribute this software is hereby granted."
		#expect(FileHeaderBuilder.recognizeLicense(in: text)?.spdxID == "ISC")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `辨識 MPL-2.0`() {
		let result = FileHeaderBuilder.recognizeLicense(in: "Mozilla Public License Version 2.0")
		#expect(result?.spdxID == "MPL-2.0")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `辨識 FSL-1.1-ALv2——不被未來授權段的 Apache 字句誤導`() {
		let text = """
			# Functional Source License, Version 1.1, ALv2 Future License
			A Permitted Purpose is any purpose other than a Competing Use.
			We hereby irrevocably grant you an additional license to use the Software under
			the Apache License, Version 2.0 that is effective on the second anniversary.
			"""
		let result = FileHeaderBuilder.recognizeLicense(in: text)
		#expect(result?.name == "Functional Source License 1.1")
		#expect(result?.spdxID == "FSL-1.1-ALv2")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `辨識 FSL-1.1-MIT——靠 mit license 詞組分流`() {
		let text = """
			# Functional Source License, Version 1.1, MIT Future License
			A Permitted Purpose is any purpose other than a Competing Use.
			We hereby irrevocably grant you an additional license to use the Software under
			the MIT license that is effective on the second anniversary.
			"""
		#expect(FileHeaderBuilder.recognizeLicense(in: text)?.spdxID == "FSL-1.1-MIT")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `辨識 GPL-3 與 GPL-2——靠標題塊版本分流`() {
		let gpl3 = "GNU GENERAL PUBLIC LICENSE\nVersion 3, 29 June 2007"
		let gpl2 = "GNU GENERAL PUBLIC LICENSE\nVersion 2, June 1991"
		#expect(FileHeaderBuilder.recognizeLicense(in: gpl3)?.spdxID == "GPL-3.0-only")
		#expect(FileHeaderBuilder.recognizeLicense(in: gpl2)?.spdxID == "GPL-2.0-only")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `辨識 LGPL 兩版與 AGPL——標題是 GPL 超集、不誤中 GPL`() {
		let lgpl3 = "GNU LESSER GENERAL PUBLIC LICENSE\nVersion 3, 29 June 2007"
		let lgpl21 = "GNU LESSER GENERAL PUBLIC LICENSE\nVersion 2.1, February 1999"
		let agpl = "GNU AFFERO GENERAL PUBLIC LICENSE\nVersion 3, 19 November 2007"
		#expect(FileHeaderBuilder.recognizeLicense(in: lgpl3)?.spdxID == "LGPL-3.0-only")
		#expect(FileHeaderBuilder.recognizeLicense(in: lgpl21)?.spdxID == "LGPL-2.1-only")
		#expect(FileHeaderBuilder.recognizeLicense(in: agpl)?.spdxID == "AGPL-3.0-only")
	}

	@Test
	private func `GPL-3 正文引用 LGPL 與 AGPL 不影響判定——前綴窗隔離`() {
		let filler = String(
			repeating: "Preamble. The licenses for most software are designed to take away your freedom. ",
			count: 5
		)
		let text = "GNU GENERAL PUBLIC LICENSE\nVersion 3, 29 June 2007\n" + filler
			+ "\nNotwithstanding any other provision, you have permission to link with the GNU Affero General Public License."
			+ "\nIf this is what you want to do, use the GNU Lesser General Public License instead of this License."
		#expect(FileHeaderBuilder.recognizeLicense(in: text)?.spdxID == "GPL-3.0-only")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `未知授權回 nil`() {
		#expect(FileHeaderBuilder.recognizeLicense(in: "Some Custom License\n\nDo whatever you want.") == nil)
	}

	@Test
	private func `isValidSPDXID 接受 idstring 與 LicenseRef`() {
		#expect(FileHeaderBuilder.isValidSPDXID("MIT"))
		#expect(FileHeaderBuilder.isValidSPDXID("FSL-1.1-ALv2"))
		#expect(FileHeaderBuilder.isValidSPDXID("GPL-3.0-or-later"))
		#expect(FileHeaderBuilder.isValidSPDXID("GPL-2.0+"))
		#expect(FileHeaderBuilder.isValidSPDXID("LicenseRef-MyTerms"))
	}

	@Test
	private func `isValidSPDXID 拒絕複合運算式與空值`() {
		#expect(!FileHeaderBuilder.isValidSPDXID(""))
		#expect(!FileHeaderBuilder.isValidSPDXID("MIT OR Apache-2.0"))
		#expect(!FileHeaderBuilder.isValidSPDXID("Apache-2.0 WITH LLVM-exception"))
		#expect(!FileHeaderBuilder.isValidSPDXID("FSL 1.1"))
	}
}

// REUSE-IgnoreEnd
