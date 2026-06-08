//
//  SwiftStyleFormatCore
//
//  SPDX-FileCopyrightText: 2026 Unpxre (GitHub: UnpxreTW)
//  SPDX-License-Identifier: MIT

extension FormatRule {

	/// ``FormatRule/testSuiteAccessControl(rule:testCaseAccessControl:)`` 的 test method
	/// 訪問控制等級
	///
	/// 對應 swiftformat 的 `test-case-access-control` option。
	public enum TestCaseAccessControl: String, FormatRuleOption {

		/// 跨 module override 都可
		case open

		/// 跨 module 可見、不可 override
		case `public`

		/// 同 SPM package 可見
		case package

		/// 同 module 可見（swiftformat 上游預設）
		case `internal`

		/// 同檔可見
		case `fileprivate`

		/// 限同 enclosing declaration scope（SwiftStyleKit 簽名預設、嚴格化 test 為 entry point）
		case `private`

		/// 對應的 swiftformat CLI option flag 名稱
		public static let flagName = "testCaseAccessControl"
	}
}
