//
//  FormatRuleTests
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("fileHeader")
private struct FileHeaderTests {

	@Test
	private func `fileHeader .disable 返空陣列`() {
		let args = FormatRule.fileHeader(
			rule: .disable,
			header: "ignore",
			dateFormat: "system",
			timeZone: "system"
		)
		.cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `fileHeader .enable 展開 --enable + header / dateFormat / timeZone`() {
		let args = FormatRule.fileHeader(
			rule: .enable,
			header: "// {file}",
			dateFormat: "iso",
			timeZone: "utc"
		)
		.cliArguments
		#expect(args == [
			"--enable", "fileHeader",
			"--header", "// {file}",
			"--dateFormat", "iso",
			"--timeZone", "utc"
		])
	}
}
