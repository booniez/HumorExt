import UIKit

public protocol ClassIdentifiable: class {
    static var reuseId: String { get }
}

extension ClassIdentifiable {
    public static var reuseId: String {
        return String(describing: self)
    }
}
