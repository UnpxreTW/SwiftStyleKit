public struct Passing {
    public let value: Int

    public init(value: Int) {
        self.value = value
    }

    public func describe() -> String {
        "Passing fixture value=\(value)"
    }
}
