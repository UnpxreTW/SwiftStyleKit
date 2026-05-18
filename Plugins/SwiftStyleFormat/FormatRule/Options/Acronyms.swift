//
// SwiftStyleFormatCore
//
// Copyright (c) 2026 Unpxre (GitHub: UnpxreTW)
// Licensed under the MIT License. See LICENSE for details.
//
// SPDX-License-Identifier: MIT

extension FormatRule {

    /// `acronyms` 規則的預設縮寫清單
    ///
    /// 分組（覆蓋 iOS app + Pi OS bare-metal 兩條主軸）：
    /// - upstream baseline：`ID`, `URL`, `UUID`
    /// - Web / API：`API`, `HTTP`, `HTTPS`, `JSON`, `IP`
    /// - 硬體：`CPU`, `GPU`, `RAM`
    /// - Pi 周邊匯流排：`GPIO`, `I2C`, `SPI`, `UART`, `USB`, `HDMI`, `SD`
    /// - microkernel 機制：`DMA`, `MMU`, `TLB`, `IRQ`, `ISR`, `MMIO`, `IO`, `IPC`, `ABI`, `EL`, `ELF`, `VM`
    /// - ARM / 韌體：`ARM`, `UEFI`, `BIOS`
    /// - 工具：`CLI`, `DSL`
    public static let defaultAcronyms: String = [
        "ID", "URL", "UUID",
        "API", "HTTP", "HTTPS", "JSON", "IP",
        "CPU", "GPU", "RAM",
        "GPIO", "I2C", "SPI", "UART", "USB", "HDMI", "SD",
        "DMA", "MMU", "TLB", "IRQ", "ISR", "MMIO", "IO",
        "IPC", "ABI", "EL", "ELF", "VM",
        "ARM", "UEFI", "BIOS",
        "CLI", "DSL"
    ].joined(separator: ",")
}
