import UIKit

public extension UIImage {
    
    /// Resizes an image to the specified size.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///
    /// - Returns: the resized image.
    ///
    func imageWithSize(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale);
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height);
        draw(in: rect)
        
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return resultingImage
    }
    
    /// Resizes an image to the specified size and adds an extra transparent margin at all sides of
    /// the image.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///     - extraMargin: the extra transparent margin to add to all sides of the image.
    ///
    /// - Returns: the resized image.  The extra margin is added to the input image size.  So that
    ///         the final image's size will be equal to:
    ///         `CGSize(width: size.width + extraMargin * 2, height: size.height + extraMargin * 2)`
    ///
    func imageWithSize(size: CGSize, extraMargin: CGFloat) -> UIImage? {
        
        let imageSize = CGSize(width: size.width + extraMargin * 2, height: size.height + extraMargin * 2)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale);
        let drawingRect = CGRect(x: extraMargin, y: extraMargin, width: size.width, height: size.height)
        draw(in: drawingRect)
        
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return resultingImage
    }
    
    /// Resizes an image to the specified size.
    ///
    /// - Parameters:
    ///     - size: the size we desire to resize the image to.
    ///     - roundedRadius: corner radius
    ///
    /// - Returns: the resized image with rounded corners.
    ///
    func imageWithSize(size: CGSize, roundedRadius radius: CGFloat) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        if let currentContext = UIGraphicsGetCurrentContext() {
            let rect = CGRect(origin: .zero, size: size)
            currentContext.addPath(UIBezierPath(roundedRect: rect,
                                                byRoundingCorners: .allCorners,
                                                cornerRadii: CGSize(width: radius, height: radius)).cgPath)
            currentContext.clip()
            
            //Don't use CGContextDrawImage, coordinate system origin in UIKit and Core Graphics are vertical oppsite.
            draw(in: rect)
            currentContext.drawPath(using: .fillStroke)
            let roundedCornerImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return roundedCornerImage
        }
        return nil
    }
}

public extension UIImage {
    convenience init?(gradientColors:[UIColor], size:CGSize = CGSize.init(width: 10, height: 10))
    {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map {(color: UIColor) -> AnyObject? in return color.cgColor as AnyObject? } as NSArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)
        // 第二个参数是起始位置，第三个参数是终止位置
        context!.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: size.width, y: 0), options: CGGradientDrawingOptions(rawValue: 0))
        self.init(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage)!)
        UIGraphicsEndImageContext()
    }
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
        self.draw(in: CGRect.init(x: 0, y: 0, width: reSize.width, height: reSize.height))
        if let reSizeImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return reSizeImage
        }
        return self
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize.init(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
    
    func resetImgSize(maxImageLenght : CGFloat,maxSizeKB : CGFloat) -> Data {
        var maxSize = maxSizeKB
        var maxImageSize = maxImageLenght
        if (maxSize <= 0.0) {
            maxSize = 1024.0;
        }
        if (maxImageSize <= 0.0)  {
            maxImageSize = 1024.0;
        }
        //先调整分辨率
        var newSize = CGSize.init(width: self.size.width, height: self.size.height)
        let tempHeight = newSize.height / maxImageSize;
        let tempWidth = newSize.width / maxImageSize;
        if (tempWidth > 1.0 && tempWidth > tempHeight) {
            newSize = CGSize.init(width: self.size.width / tempWidth, height: self.size.height / tempWidth)
        } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
            newSize = CGSize.init(width: self.size.width / tempHeight, height: self.size.height / tempHeight)
        }
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        var imageData = newImage?.jpegData(compressionQuality: 1.0)
        var sizeOriginKB : CGFloat = CGFloat((imageData?.count)!) / 1024.0;
        //调整大小
        var resizeRate = 0.9;
        while (sizeOriginKB > maxSize && resizeRate > 0.1) {
            imageData = newImage?.jpegData(compressionQuality: CGFloat(resizeRate))
            sizeOriginKB = CGFloat((imageData?.count)!) / 1024.0;
            resizeRate -= 0.1;
        }
        return imageData!
    }
    
    func getWaterMark(_ originalImage: UIImage?, title: String, andMark markFont: UIFont, andMark markColor: UIColor) -> UIImage? {
        let HORIZONTAL_SPACE: CGFloat = 30
        let VERTICAL_SPACE: CGFloat = 50
        var font: UIFont? = markFont
        if font == nil {
            font = UIFont.systemFont(ofSize: 23)
        }
        var color: UIColor? = markColor
        if color == nil {
            color = UIColor.blue
        }
        guard let viewWidth = originalImage?.size.width, let viewHeight = originalImage?.size.height else { return nil }
        UIGraphicsBeginImageContext(CGSize(width: viewWidth, height: viewHeight))
        originalImage?.draw(in: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        let sqrtLength = sqrt(viewWidth * viewWidth + viewHeight * viewHeight)
        let attrStr = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : markColor, NSAttributedString.Key.font: markFont])
        let strWidth = attrStr.size().width
        let strHeight = attrStr.size().height
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.concatenate(CGAffineTransform(translationX: viewWidth / 2, y: viewHeight / 2))
        context?.concatenate(CGAffineTransform(rotationAngle: CGFloat(M_PI_2 / 3)))
        context?.concatenate(CGAffineTransform(translationX: -viewWidth / 2, y: -viewHeight / 2))
        
        let horCount: Int = Int(sqrtLength / CGFloat(strWidth + HORIZONTAL_SPACE)) + 1
        let verCount: Int = Int(sqrtLength / CGFloat(strHeight + VERTICAL_SPACE)) + 1
        let orignX: CGFloat = -(sqrtLength - viewWidth) / 2
        let orignY: CGFloat = -(sqrtLength - viewHeight) / 2
        var tempOrignX: CGFloat = orignX
        var tempOrignY: CGFloat = orignY
        for i in 0..<horCount * verCount {
            title.draw(in: CGRect(x: tempOrignX, y: tempOrignY, width: strWidth, height: strHeight), withAttributes: [NSAttributedString.Key.foregroundColor : markColor, NSAttributedString.Key.font: markFont])
            if i % horCount == 0 && i != 0 {
                tempOrignX = orignX
                tempOrignY += strHeight + VERTICAL_SPACE
            } else {
                tempOrignX += strWidth + HORIZONTAL_SPACE
            }
        }
        let finalImg: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImg
    }
}
