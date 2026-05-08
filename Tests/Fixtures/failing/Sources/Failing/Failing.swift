public struct Failing {
    public func unsafeCast(_ value: Any) -> String {
        return value as! String
    }
}
