import UIKit

protocol NibIdentifiable: class {
    static var nib: UINib { get }
}

extension NibIdentifiable {
    public static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension NibIdentifiable where Self: UIView {
    public static func initFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self
            else { fatalError("Couldn't find nib file for \(self)") }
        return view
    }
}

extension NibIdentifiable where Self: UITableView {
    public static func initFromNib() -> Self {
        guard let tableView = nib.instantiate(withOwner: nil, options: nil).first as? Self
            else { fatalError("Couldn't find nib file for \(self)") }
        return tableView
    }
}

extension NibIdentifiable where Self: UICollectionView {
    public static func initFromNib() -> Self {
        guard let collectionView = nib.instantiate(withOwner: nil, options: nil).first as? Self
            else { fatalError("Couldn't find nib file for \(self)") }
        return collectionView
    }
}

extension NibIdentifiable where Self: UIViewController {
    public static func initFromNib() -> Self {
       return Self(nibName: nibIdentifier, bundle: nil)
    }
}

extension UIViewController: NibIdentifiable {
    public static var nibIdentifier: String {
        return String(describing: self)
    }
}
