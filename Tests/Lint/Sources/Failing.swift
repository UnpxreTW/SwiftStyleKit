import Foundation

public struct Failing {
    public func cast(_ any: Any) -> String {
        return any as! String
    }
}
