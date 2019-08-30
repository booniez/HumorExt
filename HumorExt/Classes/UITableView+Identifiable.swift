import UIKit

extension UITableView {

    public func register<T: UITableViewCell>(cellType: T.Type) where T: ClassIdentifiable {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseId)
    }

    public func register<T: UITableViewCell>(cellType: T.Type) where T: NibIdentifiable & ClassIdentifiable {
        register(cellType.nib, forCellReuseIdentifier: cellType.reuseId)
    }

    public func registerHeaderFooter<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: ClassIdentifiable {
        register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.reuseId)
    }

    public func registerHeaderFooter<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: NibIdentifiable & ClassIdentifiable {
        register(viewType.nib, forHeaderFooterViewReuseIdentifier: viewType.reuseId)
    }

    public func dequeueReusableCell<T: UITableViewCell>(withCellType type: T.Type = T.self) -> T where T: ClassIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: type.reuseId) as? T
            else { fatalError("Couldn't dequeue a UITableViewCell with identifier: \(type.reuseId)") }
        return cell
    }

    public func dequeueReusableCell<T: UITableViewCell>(withCellType type: T.Type = T.self, for indexPath: IndexPath) -> T where T: ClassIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: type.reuseId, for: indexPath) as? T
            else { fatalError("Couldn't dequeue a UITableViewCell with identifier: \(type.reuseId)") }
        return cell
    }

    public func dequeueResuableHeaderFooterView<T: UITableViewHeaderFooterView>(withViewType type: T.Type) -> T where T: ClassIdentifiable {
        guard let headerFooterView = self.dequeueReusableHeaderFooterView(withIdentifier: type.reuseId) as? T
            else { fatalError("Couldn't dequeue a UITableViewHeaderFooterView with identifier: \(type.reuseId)") }
        return headerFooterView
    }
}
