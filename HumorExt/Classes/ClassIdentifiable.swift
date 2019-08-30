import UIKit

protocol ClassIdentifiable: class {
    static var reuseId: String { get }
}

public extension ClassIdentifiable {
    static var reuseId: String {
        return String(describing: self)
    }
}
