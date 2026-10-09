//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

import Foundation

extension FileHeaderBuilder {

	/// 授權來源檔的候選檔名（同一層依此順序嘗試）
	public static let licenseFileNames: [String] = ["LICENSE", "LICENSE.md", "LICENSE.txt"]

	/// 版權聲明來源檔的候選檔名（同一層依此順序嘗試）
	public static let noticeFileNames: [String] = ["NOTICE", "NOTICE.md", "NOTICE.txt"]

	/// 作者清單來源檔的候選檔名（同一層依此順序嘗試）
	public static let authorsFileNames: [String] = ["AUTHORS", "AUTHORS.md", "AUTHORS.txt"]

	/// 檔頭來源檔（`LICENSE`／`NOTICE`／`AUTHORS`）的搜尋目錄，由近到遠
	///
	/// 自 `directory` 起逐層往上，停在祖先鏈中最外層含 `Package.swift` 的目錄（含該目錄）。
	/// 子 package 因此能取用 repo 根目錄的來源檔；中間層沒有 manifest 的目錄（例如
	/// `Packages/`）照樣經過、不當作邊界。祖先鏈上都沒有 `Package.swift` 時只回
	/// `directory` 本身、不往外找。
	///
	/// 不以 `.git` 判斷 repo 根：格式化可能在不含 `.git` 的工作樹複本上執行。
	public static func headerSourceDirectories(from directory: String) -> [String] {
		let chain: [String] = ancestorChain(of: directory)
		let manager: FileManager = .default
		let outermost: Int = chain.lastIndex { manager.fileExists(atPath: $0 + "/Package.swift") } ?? 0
		return Array(chain[...outermost])
	}

	/// 依搜尋目錄由近到遠，讀出第一個存在且可讀的來源檔內容
	///
	/// 同一層依 `fileNames` 順序嘗試、該層全無才往下一個目錄；`LICENSE`、`NOTICE`、`AUTHORS`
	/// 各自呼叫一次，彼此獨立就近（例如 `LICENSE` 取 repo 根、`NOTICE` 取 package 目錄）。
	/// 全部找不到回 `nil`。
	public static func nearestSourceText(fileNames: [String], in directories: [String]) -> String? {
		for directory in directories {
			for name in fileNames {
				let url: URL = .init(fileURLWithPath: directory + "/" + name)
				if let text: String = try? String(contentsOf: url, encoding: .utf8) {
					return text
				}
			}
		}
		return nil
	}

	/// `directory` 與其全部祖先目錄，由近到遠（標準化後的絕對路徑、不解開 symlink）
	private static func ancestorChain(of directory: String) -> [String] {
		var current: URL = .init(fileURLWithPath: directory).standardizedFileURL
		var chain: [String] = [current.path]
		while current.path != "/" {
			let parent: URL = current.deletingLastPathComponent().standardizedFileURL
			guard parent.path != current.path else { break }
			chain.append(parent.path)
			current = parent
		}
		return chain
	}
}
