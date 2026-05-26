//
// FormatRuleTests
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

import SwiftStyleFormatCore
import Testing

@Suite("fileMacro")
private struct FileMacroTests {

	@Test
	private func `fileMacro .disable 返空陣列`() {
		let args = FormatRule.fileMacro(rule: .disable, mode: .file).cliArguments
		#expect(args.isEmpty)
	}

	@Test
	private func `fileMacro .enable（mode 預設 .fileID）展開 --enable + --fileMacro #fileID`() {
		let args = FormatRule.fileMacro(rule: .enable).cliArguments
		#expect(args == [
			"--enable", "fileMacro",
			"--fileMacro", "#fileID"
		])
	}

	@Test
	private func `fileMacro .enable mode .file 展開 --fileMacro #file`() {
		let args = FormatRule.fileMacro(rule: .enable, mode: .file).cliArguments
		#expect(args == [
			"--enable", "fileMacro",
			"--fileMacro", "#file"
		])
	}
}
