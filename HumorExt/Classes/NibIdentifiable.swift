import UIKit

protocol NibIdentifiable: class {
    static var nib: UINib { get }
}

public extension NibIdentifiable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

public extension NibIdentifiable where Self: UIView {
    static func initFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self
            else { fatalError("Couldn't find nib file for \(self)") }
        return view
    }
}

public extension NibIdentifiable where Self: UITableView {
    static func initFromNib() -> Self {
        guard let tableView = nib.instantiate(withOwner: nil, options: nil).first as? Self
            else { fatalError("Couldn't find nib file for \(self)") }
        return tableView
    }
}

public extension NibIdentifiable where Self: UICollectionView {
    static func initFromNib() -> Self {
        guard let collectionView = nib.instantiate(withOwner: nil, options: nil).first as? Self
            else { fatalError("Couldn't find nib file for \(self)") }
        return collectionView
    }
}

public extension NibIdentifiable where Self: UIViewController {
    static func initFromNib() -> Self {
       return Self(nibName: nibIdentifier, bundle: nil)
    }
}

public extension UIViewController: NibIdentifiable {
    static var nibIdentifier: String {
        return String(describing: self)
    }
}
