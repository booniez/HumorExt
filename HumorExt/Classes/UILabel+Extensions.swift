import UIKit

public extension UILabel {
    class func label(textColor: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = font
        return label
    }
}
