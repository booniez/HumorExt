import UIKit
import Foundation

// MARK: - Designable Extension

@IBDesignable
public extension UIView {
    
    @IBInspectable
    /// Should the corner be as circle
    var circleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
        }
        set {
            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }
    
    @IBInspectable
    /// Corner radius of view; also inspectable from Storyboard.
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = circleCorner ? min(bounds.size.height, bounds.size.width) / 2 : newValue
                //abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    @IBInspectable
    /// Border color of view; also inspectable from Storyboard.
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }
    
    @IBInspectable
    /// Border width of view; also inspectable from Storyboard.
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    /// Shadow color of view; also inspectable from Storyboard.
    var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    /// Shadow offset of view; also inspectable from Storyboard.
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    /// Shadow opacity of view; also inspectable from Storyboard.
    var shadowOpacity: Double {
        get {
            return Double(layer.shadowOpacity)
        }
        set {
            layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable
    /// Shadow radius of view; also inspectable from Storyboard.
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    /// Shadow path of view; also inspectable from Storyboard.
    var shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set {
            layer.shadowPath = newValue
        }
    }
    
    @IBInspectable
    /// Should shadow rasterize of view; also inspectable from Storyboard.
    /// cache the rendered shadow so that it doesn't need to be redrawn
    var shadowShouldRasterize: Bool {
        get {
            return layer.shouldRasterize
        }
        set {
            layer.shouldRasterize = newValue
        }
    }
    
    @IBInspectable
    /// Should shadow rasterize of view; also inspectable from Storyboard.
    /// cache the rendered shadow so that it doesn't need to be redrawn
    var shadowRasterizationScale: CGFloat {
        get {
            return layer.rasterizationScale
        }
        set {
            layer.rasterizationScale = newValue
        }
    }
    
    @IBInspectable
    /// Corner radius of view; also inspectable from Storyboard.
    var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
}


// MARK: - Properties

public extension UIView {
    
    /// Size of view.
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    /// Width of view.
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    /// Height of view.
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
}

public extension UIView {
    
    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview.flatMap { $0.superview(of: T.self) }
    }
    
}


// MARK: - Methods

public extension UIView {
    
    typealias Configuration = (UIView) -> Swift.Void
    
    func config(configurate: Configuration?) {
        configurate?(self)
    }
    
    /// Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}


public extension UIView {
    var x : CGFloat {
        get{
            return self.frame.origin.x
        }
        set{
            var newFrame = self.frame
            newFrame.origin.x = newValue
            self.frame = newFrame
        }
    }
    var y : CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var newFrame = self.frame
            newFrame.origin.y = newValue
            self.frame = newFrame
        }
    }    
}

public extension UIView {
    
    func getX() -> CGFloat {
        return frame.minX
    }
    
    func getY() -> CGFloat {
        return frame.minY
    }
    
    func getWidth() -> CGFloat {
        return frame.width
    }
    
    func getHeight() -> CGFloat {
        return frame.height
    }
    
    func getBottom() -> CGFloat {
        return frame.maxY
    }
    
    func getRight() -> CGFloat {
        return frame.maxX
    }
    
    func getSize() -> CGSize {
        return frame.size
    }
    
    class func getStatusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    class func getNavigationBarHeight() -> CGFloat {
        return UINavigationController().navigationBar.getHeight()
    }
    
    class func getNavigationBarBottom() -> CGFloat {
        return UIView.getStatusBarHeight() + UIView.getNavigationBarHeight()
    }
    
    func setX(newX: CGFloat) {
        frame = CGRect(x: newX, y: getY(), width: getWidth(), height: getHeight())
    }
    
    func setY(newY: CGFloat) {
        frame = CGRect(x: getX(), y: newY, width: getWidth(), height: getHeight())
    }
    
    func setWidth(newWidth: CGFloat) {
        frame = CGRect(x: getX(), y: getY(), width: newWidth, height: getHeight())
    }
    
    func setHeight(newHeight: CGFloat) {
        frame = CGRect(x: getX(), y: getY(), width: getWidth(), height: newHeight)
    }
    
    func setPosition(newPosition: CGPoint) {
        frame = CGRect(x: newPosition.x, y: newPosition.y, width: getWidth(), height: getHeight())
    }
    
    func setSize(newSize: CGSize) {
        frame = CGRect(x: getX(), y: getY(), width: newSize.width, height: newSize.height)
    }
}
