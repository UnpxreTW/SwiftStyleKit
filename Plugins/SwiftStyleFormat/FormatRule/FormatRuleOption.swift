//
//  SwiftStyleFormatCore
//
//  Copyright © 2026 Unpxre (GitHub: UnpxreTW)
//  Licensed under the MIT License. See LICENSE for details.
//
//  SPDX-License-Identifier: MIT

/// swiftformat 規則的「附帶選項」型別
///
/// case 的 option associated value 型別 conform 此 protocol 後，reflection chain
/// 會用 `flagName` 取得對應的 swiftformat CLI option flag 名稱，而非沿用 Swift
/// 參數 label。讓 case 簽名的參數 label 可取人類可讀名（例如 `mode:`），與底層
/// swiftformat flag 名（例如 `--blankLineAfterSwitchCase`）解耦。
///
/// swiftformat 對 option flag 命名並不一致：部分規則的 option flag 等於規則名
/// （`acronyms`、`blankLineAfterSwitchCase`），部分另取名（`blankLinesAroundMark`
/// 的 option flag 為 `--lineaftermarks`）。flag 名因此必須由型別明確宣告、不可從
/// 規則名或參數 label 推導。
///
/// `cliValue` 由 default extension 對 String RawRepresentable 自動取 `rawValue`；
/// 帶 associated value 的 enum（如 ``FormatRule/PreferSynthesizedInitMode``）需於
/// 自身型別實作 `cliValue`。default extension 見 ``FormatRuleOption+RawValue``。
public protocol FormatRuleOption {

	/// 對應的 swiftformat CLI option flag 名稱（不含 `--` 前綴）
	static var flagName: String { get }

	/// option 值轉成 swiftformat CLI 所接受的字串
	var cliValue: String { get }
}
