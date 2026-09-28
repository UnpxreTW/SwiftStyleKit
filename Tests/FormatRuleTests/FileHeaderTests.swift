//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("fileHeader")
private struct FileHeaderTests {

	@Test
	private func `fileHeader .disable 返空陣列`() {
		let args = FormatRule.fileHeader(.off).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `fileHeader .enable 展開 --enable + header / dateFormat / timeZone`() {
		let args = FormatRule.fileHeader(
			.on,
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

	@Test
	private func `fileHeader .enable 省略 option 時展開 swiftformat 的工具預設`() {
		let args = FormatRule.fileHeader(.on).cliArguments
		#expect(args == [
			"--enable", "fileHeader",
			"--header", "ignore",
			"--dateFormat", "system",
			"--timeZone", "system"
		])
	}
}
