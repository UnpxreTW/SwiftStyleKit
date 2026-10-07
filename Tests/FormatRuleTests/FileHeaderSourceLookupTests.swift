//
//  FormatRuleTests
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import Foundation
import SwiftStyleFormatCore
import Testing

// MARK: - FileHeaderSourceLookupTests

@Suite("FileHeaderBuilder 來源檔就近搜尋")
private struct FileHeaderSourceLookupTests {

	@Test
	private func `package 目錄自身有 LICENSE 即取用`() throws {
		let root: String = try makeTree([
			"repo/Package.swift": "",
			"repo/LICENSE": "repo license"
		])
		defer { removeTree(root) }
		let directories: [String] = FileHeaderBuilder.headerSourceDirectories(from: root + "/repo")
		#expect(directories == [root + "/repo"])
		#expect(licenseText(in: directories) == "repo license")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `子 package 往上取用 repo 根目錄的 LICENSE`() throws {
		let root: String = try makeTree([
			"repo/Package.swift": "",
			"repo/LICENSE": "repo license",
			"repo/Packages/Kit/Package.swift": ""
		])
		defer { removeTree(root) }
		let directories: [String] = FileHeaderBuilder.headerSourceDirectories(from: root + "/repo/Packages/Kit")
		// 中間層 Packages/ 沒有 manifest，仍在搜尋路徑內、不當作邊界
		#expect(directories == [root + "/repo/Packages/Kit", root + "/repo/Packages", root + "/repo"])
		#expect(licenseText(in: directories) == "repo license")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `最外層 Package.swift 之外的檔案不取用`() throws {
		let root: String = try makeTree([
			"LICENSE": "outside license",
			"repo/Package.swift": "",
			"repo/Packages/Kit/Package.swift": ""
		])
		defer { removeTree(root) }
		let directories: [String] = FileHeaderBuilder.headerSourceDirectories(from: root + "/repo/Packages/Kit")
		#expect(directories.last == root + "/repo")
		#expect(licenseText(in: directories) == nil)
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `較近一層的 LICENSE 優先`() throws {
		let root: String = try makeTree([
			"repo/Package.swift": "",
			"repo/LICENSE": "repo license",
			"repo/Packages/Kit/Package.swift": "",
			"repo/Packages/Kit/LICENSE": "kit license"
		])
		defer { removeTree(root) }
		let directories: [String] = FileHeaderBuilder.headerSourceDirectories(from: root + "/repo/Packages/Kit")
		#expect(licenseText(in: directories) == "kit license")
	}

	@Test
	private func `LICENSE 與 NOTICE 各自就近找`() throws {
		let root: String = try makeTree([
			"repo/Package.swift": "",
			"repo/LICENSE": "repo license",
			"repo/Packages/Kit/Package.swift": "",
			"repo/Packages/Kit/NOTICE": "kit notice"
		])
		defer { removeTree(root) }
		let directories: [String] = FileHeaderBuilder.headerSourceDirectories(from: root + "/repo/Packages/Kit")
		#expect(licenseText(in: directories) == "repo license")
		let notice: String? = FileHeaderBuilder.nearestSourceText(
			fileNames: FileHeaderBuilder.noticeFileNames,
			in: directories
		)
		#expect(notice == "kit notice")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func 同層依候選檔名順序取用() throws {
		let root: String = try makeTree([
			"repo/Package.swift": "",
			"repo/LICENSE.md": "markdown license",
			"repo/LICENSE.txt": "text license"
		])
		defer { removeTree(root) }
		let directories: [String] = FileHeaderBuilder.headerSourceDirectories(from: root + "/repo")
		#expect(licenseText(in: directories) == "markdown license")
	}

	@Test
	// swiftlint:disable:next identifier_name
	private func `祖先都沒有 Package.swift 時只找起點目錄`() throws {
		let root: String = try makeTree([
			"LICENSE": "outside license",
			"project/Sources/main.swift": ""
		])
		defer { removeTree(root) }
		let directories: [String] = FileHeaderBuilder.headerSourceDirectories(from: root + "/project")
		#expect(directories == [root + "/project"])
		#expect(licenseText(in: directories) == nil)
	}

	/// 在暫存目錄下建一棵檔案樹、回傳樹根的標準化路徑；`files` 的鍵為相對路徑、值為檔案內容
	private func makeTree(_ files: [String: String]) throws -> String {
		let manager: FileManager = .default
		let root: URL = manager.temporaryDirectory
			.appendingPathComponent("FileHeaderSourceLookupTests-" + UUID().uuidString)
			.standardizedFileURL
		for (path, content) in files {
			let url: URL = root.appendingPathComponent(path)
			try manager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
			try content.write(to: url, atomically: true, encoding: .utf8)
		}
		return root.path
	}

	/// 移除 `makeTree` 建立的暫存樹
	private func removeTree(_ root: String) {
		try? FileManager.default.removeItem(atPath: root)
	}

	/// 依 `LICENSE` 候選檔名在搜尋目錄內就近讀檔
	private func licenseText(in directories: [String]) -> String? {
		FileHeaderBuilder.nearestSourceText(fileNames: FileHeaderBuilder.licenseFileNames, in: directories)
	}
}
