//
//  Extensions+UIImage.swift
//  Core_IOS_MVVM
//
//  Created by Apple on 3/4/20.
//  Copyright © 2020 Chhany. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation

public extension UIImageView {
    func imageround() {
        layer.masksToBounds = true
        setCornerRadious()
        contentMode = .scaleAspectFit
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.5
    }

    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setCornerRadious() {
        let radius = self.frame.height / 20
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

public extension UIImage {
    var hasAlphaChannel: Bool {
        guard let cgImage = cgImage else { return false }
        guard let alpha = CGImageAlphaInfo(rawValue: cgImage.alphaInfo.rawValue & CGBitmapInfo.alphaInfoMask.rawValue) else { return false }
        return alpha == .first || alpha == .last || alpha == .premultipliedFirst || alpha == .premultipliedLast
    }
    var jpegBytesSize: Int {
        return jpegData(compressionQuality: 1)?.count ?? 0
    }
    var pngBytesSize: Int {
        return pngData()?.count ?? 0
    }
    var jpegKbSize: Double {
        return Double(String(format: "%.2f", Double(jpegBytesSize) / 1024.0))!
    }
    var pngKbSize: Double {
        return Double(String(format: "%.2f", Double(pngBytesSize) / 1024.0))!
    }
    var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    func remake(alpha: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        draw(in: rect, blendMode: .normal, alpha: alpha)
        if let output = UIGraphicsGetImageFromCurrentImageContext() {
            return output
        }
        return self
    }
}
// MARK: - 方法
public extension UIImage {
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else { return nil }
        return UIImage(data: data)
    }
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return jpegData(compressionQuality: quality)
    }
    func resize(to size: CGSize, contentMode: UIView.ContentMode? = nil, opaque: Bool = false) -> UIImage? {
        guard size.width >= 0 && size.height >= 0 else { return nil }
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
        defer { UIGraphicsEndImageContext() }
        if let contentMode = contentMode {
            draw(in: CGRect(origin: CGPoint.zero, size: size), mode: contentMode, clips: false)
        } else {
            draw(in: CGRect(origin: CGPoint.zero, size: size))
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func draw(in rect: CGRect, mode: UIView.ContentMode, clips: Bool) {
        let rec = rect.rectFit(size: size, mode: mode)
        guard rec.size.width >= 0 && rec.size.height >= 0 else { return }
        if clips {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            context.saveGState()
            context.addRect(rect)
            context.clip()
            draw(in: rec)
            context.restoreGState()
        } else {
            draw(in: rec)
        }
    }
    func cropping(from rect: CGRect) -> UIImage? {
        var rec = rect
        rec.origin.x *= scale
        rec.origin.y *= scale
        rec.size.width *= scale
        rec.size.height *= scale
        guard rec.size.width > 0 && rec.size.height > 0 else { return nil }
        if let cgImage = cgImage?.cropping(to: rec) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
    func cropping(from path: CGPath) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.addPath(path)
        context.closePath()
        context.clip()
        draw(at: CGPoint.zero)
        return UIGraphicsGetImageFromCurrentImageContext()?.cropping(from: path.boundingBox)
    }
    func cropping(rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        draw(at: CGPoint.zero)
        context.clear(rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func cropping(path: CGPath) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        draw(at: CGPoint.zero)
        context.addPath(path)
        context.closePath()
        context.setBlendMode(.clear)
        context.fillPath()
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func roundedCorner(radius: CGFloat, corners: UIRectCorner = [.allCorners], size: CGSize? = nil, mode: UIView.ContentMode? = nil,
                       borderWidth: CGFloat? = nil, borderColor: UIColor? = nil, borderLineJoin: CGLineJoin? = nil) -> UIImage? {
        let mSize = size ?? self.size
        UIGraphicsBeginImageContextWithOptions(mSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let cGRect = CGRect(origin: CGPoint.zero, size: mSize)
        let minSize = min(mSize.width, mSize.height)
        let mBW = borderWidth ?? 0
        if mBW < minSize / 2 {
            let path = UIBezierPath(roundedRect: cGRect.insetBy(dx: mBW, dy: mBW), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: mBW))
            context.addPath(path.cgPath)
            context.saveGState()
            context.clip()
            if let mode = mode {
                draw(in: cGRect, mode: mode, clips: true)
            } else {
                draw(in: cGRect)
            }
            context.restoreGState()
        }
        if mBW < minSize / 2 && mBW > 0 {
            let strokeInsert = (floor(mBW * scale) + 0.5) / scale
            let strokeRect = cGRect.insetBy(dx: strokeInsert, dy: strokeInsert)
            let strokeRadius = radius > scale / 2 ? radius - scale / 2 : 0
            let path = UIBezierPath(roundedRect: strokeRect, byRoundingCorners: corners, cornerRadii: CGSize(width: strokeRadius, height: mBW))
            path.close()
            path.lineWidth = mBW
            if let borderColor = borderColor {
                borderColor.setStroke()
            } else {
                UIColor.clear.setStroke()
            }
            if let borderLineJoin = borderLineJoin {
                path.lineJoinStyle = borderLineJoin
            }
            path.stroke()
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func rotated(by radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: size).applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(), height: destRect.height.rounded())
        UIGraphicsBeginImageContext(roundedDestRect.size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        context.rotate(by: radians)
        draw(in: CGRect(origin: CGPoint(x: -size.width / 2, y: -size.height / 2), size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func tint(by color: UIColor, blendMode: CGBlendMode) -> UIImage? {
        let drawRect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        color.setFill()
        context.fill(drawRect)
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func rotate180() -> UIImage? {
        guard let cgImg = cgImage else { return nil }
        return UIImage(cgImage: cgImg, scale: scale, orientation: .down)
    }
    func rotateLeft90() -> UIImage? {
        guard let cgImg = cgImage else { return nil }
        return UIImage(cgImage: cgImg, scale: scale, orientation: .left)
    }
    func rotateRight90() -> UIImage? {
        guard let cgImg = cgImage else { return nil }
        return UIImage(cgImage: cgImg, scale: scale, orientation: .right)
    }
    func flipHorizontal() -> UIImage? {
        guard let cgImg = cgImage else { return nil }
        return UIImage(cgImage: cgImg, scale: scale, orientation: .upMirrored)
    }
    func flipVertical() -> UIImage? {
        guard let cgImg = cgImage else { return nil }
        return UIImage(cgImage: cgImg, scale: scale, orientation: .downMirrored)
    }
}

public extension UIImage {
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer {
            UIGraphicsEndImageContext()
        }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
}
