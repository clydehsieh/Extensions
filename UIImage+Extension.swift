//
//  UIImage+Extension.swift
//  Extensions
//
//  Created by ClydeHsieh on 2022/5/14.
//

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

//MARK: - render
extension UIImage {
    static func squarePoint(color: UIColor) -> UIImage {
        UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
            .image { context in
                color.setFill()
                context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            }
    }
    
    static func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsImageRenderer(size: CGSize(width: diameter, height: diameter))
            .image { context in
                color.setFill()
                context.cgContext.fillEllipse(in: CGRect(x: 0, y: 0, width: diameter, height: diameter))
            }
    }
    
    func blur(amount: Float) -> UIImage? {
        let context = CIContext(options: nil)
        let blur = CIFilter.gaussianBlur()
        blur.inputImage = CIImage(image: self)
        blur.radius = amount

        if let output = blur.outputImage {
            if let cgimg = context.createCGImage(output, from: output.extent) {
                let processedImage = UIImage(cgImage: cgimg)
                return processedImage
            }
        }
        
        return nil
    }
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1), blur: CGFloat? = nil) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}


//MARK: - convert
extension UIImage {
    func convertImageToJpegBase64() -> String? {
        let imageData: Data = jpegData(compressionQuality: 0.8)!
        
        // let imageSize: Int = imageData.count
        // print("size of image in KB: ", imageSize / 1024)
        
        var base64String = (imageData as NSData).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        base64String = base64String.replacingOccurrences(of: "\r\n", with: "")
        return String(format: "data:image/jpeg;base64,\(base64String)")
        
    }
    
    func convertImageToBase64(ratio: CGFloat = 0.5) -> String? {
        
        let imageData: Data = jpegData(compressionQuality: ratio)!
        let base64String = (imageData as NSData).base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String.replacingOccurrences(of: "\r\n", with: "")
    }
}

//MARK: - sizing
extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    func resizeAspeftFitIfNeed(maxLength length: CGFloat) -> UIImage? {
        guard max(self.size.width, self.size.height) > length else { return nil }
        return resize(targetSize: sizeAspectFit(maxLength: length))
    }
    
    func sizeAspectFit(maxLength length: CGFloat) -> CGSize {
        guard length > 0 else { return .zero }
        let originSize = self.size
        let ratio = length / max(originSize.width, originSize.height)
        return .init(width: originSize.width * ratio, height: originSize.height * ratio)
    }
}

//MARK: - shape
extension UIImage {
    static func shaped(
        withBezierPath bezierPath: UIBezierPath,
        fillColor: UIColor = .clear,
        strokeColor: UIColor = .clear,
        strokeWidth: CGFloat = 0
    ) -> UIImage {
        return UIGraphicsImageRenderer(size: CGSize(
            width: bezierPath.bounds.width + strokeWidth,
            height: bezierPath.bounds.height + strokeWidth
        )).image { context in
            let normalizeTransform = CGAffineTransform(
                translationX: -bezierPath.bounds.minX + strokeWidth / 2,
                y: -bezierPath.bounds.minY + strokeWidth / 2
            )
            bezierPath.apply(normalizeTransform)
            let cgContext = context.cgContext
            cgContext.addPath(bezierPath.cgPath)
            cgContext.setFillColor(fillColor.cgColor)
            cgContext.setStrokeColor(strokeColor.cgColor)
            cgContext.setLineWidth(strokeWidth)
            cgContext.drawPath(using: .fillStroke)
        }
    }
    
    static func rect(radius: CGFloat, frame: CGRect, fillColor: UIColor = .clear, strokeColor: UIColor = .clear, strokeWidth: CGFloat = 0) -> UIImage {
        let path = UIBezierPath(
            rect: frame
        )
        let image = UIImage.shaped(withBezierPath: path, fillColor: fillColor, strokeColor: strokeColor, strokeWidth: strokeWidth)
        return image.resizableImageByRadius(radius)
    }
    
    static func roundedRect(radius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .clear, strokeColor: UIColor = .clear, strokeWidth: CGFloat = 0) -> UIImage {
        let path = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2),
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let image = UIImage.shaped(withBezierPath: path, fillColor: fillColor, strokeColor: strokeColor, strokeWidth: strokeWidth)
        return image.resizableImageByRadius(radius)
    }
    
    static func oval(radius: CGFloat, fillColor: UIColor = .clear, strokeColor: UIColor = .clear, strokeWidth: CGFloat = 0) -> UIImage {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
        let image = UIImage.shaped(withBezierPath: path, fillColor: fillColor, strokeColor: strokeColor, strokeWidth: strokeWidth)
        return image.resizableImageByRadius(radius)
    }
    
    static func pill(withColor fillColor: UIColor, radius: CGFloat) -> UIImage {
        oval(radius: radius, fillColor: fillColor)
    }
    
    static func emptyPill(withStrokeColor strokeColor: UIColor, strokeWidth: CGFloat, radius: CGFloat) -> UIImage {
        oval(radius: radius, strokeColor: strokeColor, strokeWidth: strokeWidth)
    }
    
    func resizableImageByRadius(_ radius: CGFloat) -> UIImage {
        resizableImage(
            withCapInsets: UIEdgeInsets(top: radius, left: radius, bottom: radius, right: radius),
            resizingMode: .stretch
        )
    }
}
