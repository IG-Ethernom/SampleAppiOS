//
//  CoreGraphics+public extension.swift
//  Bamboo Consumer
//
//  Created by Puttheavy tep on 18/1/2566 BE.
//

import Foundation
import CoreGraphics
import UIKit

// MARK: -

public extension Double {
    var radian: CGFloat {
        return CGFloat(self / 180.0 * Double.pi)
    }
    
    var angle: CGFloat {
        return CGFloat(self / Double.pi * 180.0)
    }
    
    var pointToPixel: CGFloat {
        return CGFloat(self) * UIScreen.main.scale
    }
    
    var pixelToPoint: CGFloat {
        return CGFloat(self) / UIScreen.main.scale
    }
}

public extension CGFloat {
    var radian: CGFloat {
        return CGFloat(Double(native / 180.0) * Double.pi)
    }
    
    var angle: CGFloat {
        return CGFloat(Double(native) / Double.pi * 180.0)
    }
    
    var pointToPixel: CGFloat {
        return self * UIScreen.main.scale
    }
    
    var pixelToPoint: CGFloat {
        return self / UIScreen.main.scale
    }
}

public extension CGFloat {
    var ceilling: CGFloat { return ceil(self) }
    var flooring: CGFloat { return floor(self) }
}

public extension CGPoint {
    var ceilling: CGPoint { return CGPoint(x: ceil(x), y: ceil(y)) }
    var flooring: CGPoint { return CGPoint(x: floor(x), y: floor(y)) }
    
    func makeVector(to other: CGPoint) -> CGVector {
        return CGVector(dx: other.x - x, dy: y - other.y)
    }
}

let CGPointZert = CGPoint.zero

func CGPointMake(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
    return CGPoint(x: x, y: y)
}

func CGPointMake(_ x: Double, _ y: Double) -> CGPoint {
    return CGPoint(x: x, y: y)
}

func CGPointMake(_ x: Int, _ y: Int) -> CGPoint {
    return CGPoint(x: x, y: y)
}

// MARK: -

public extension CGSize {
    var ceilling: CGSize { return CGSize(width: ceil(width), height: ceil(height)) }
    var flooring: CGSize { return CGSize(width: floor(width), height: floor(height)) }
    
    /// Multiply the size components by the factor
    func scale(factor: CGFloat) -> CGSize {
        return CGSize(width: width * factor, height: height * factor)
    }
    
    /// Calculate scale for fitting a size to a destination size
    func scale(aspectToFit size: CGSize) -> CGSize {
        return scale(factor: min(size.width / width, size.height / height))
    }
    
    // Calculate scale for filling a destination size
    func scale(aspectToFill size: CGSize) -> CGSize {
        return scale(factor: max(size.width / width, size.height / height))
    }
}

let CGSizeZert = CGSize.zero

func CGSizeMake(_ width: CGFloat, _ height: CGFloat) -> CGSize {
    return CGSize(width: width, height: height)
}

func CGSizeMake(_ width: Double, _ height: Double) -> CGSize {
    return CGSize(width: width, height: height)
}

func CGSizeMake(_ width: Int, _ height: Int) -> CGSize {
    return CGSize(width: width, height: height)
}

func CGSizeEqualToSize(_ lhs: CGSize, _ rhs: CGSize) -> Bool {
    return lhs.equalTo(rhs)
}

// MARK: -

public extension CGVector {
    var ceilling: CGVector { return CGVector(dx: ceil(dx), dy: ceil(dy)) }
    var flooring: CGVector { return CGVector(dx: floor(dx), dy: floor(dy)) }
}

func CGVectorMake(_ dx: CGFloat, dy: CGFloat) -> CGVector {
    return CGVector(dx: dx, dy: dy)
}

func CGVectorMake(_ dx: Double, dy: Double) -> CGVector {
    return CGVector(dx: dx, dy: dy)
}

func CGVectorMake(_ dx: Int, dy: Int) -> CGVector {
    return CGVector(dx: dx, dy: dy)
}

// MARK: -

public extension CGRect {
    var ceilling: CGRect { return CGRectMake(size: size.ceilling) }
    var flooring: CGRect { return CGRectMake(size: size.flooring) }
    
    /// Return a rect centered a source to a destination
    func centering(in destination: CGRect) -> CGRect {
        let dx: CGFloat = destination.midX - midX
        let dy: CGFloat = destination.midY - midY
        return offsetBy(dx: dx, dy: dy)
    }
    
    /// Return a rect fitting a source to a destination
    func fitting(in destination: CGRect) -> CGRect {
        let targetSize = size.scale(aspectToFit: destination.size)
        return CGRectMake(center: destination.center, size: targetSize)
    }
    
    /// Return a rect that fills the destination
    func filling(in destination: CGRect) -> CGRect {
        let targetSize = size.scale(aspectToFill: destination.size)
        return CGRectMake(center: destination.center, size: targetSize)
    }
    
    var left: CGFloat {
        set {
            var newOrigin = origin
            newOrigin.x = newValue
            origin = newOrigin
        }
        get { return origin.x }
    }
    
    var centerX: CGFloat {
        set {
            let diff = newValue - midX
            var newOrigin = origin
            newOrigin.x += diff
            origin = newOrigin
        }
        get { return origin.x + size.width / 2.0 }
    }
    
    var right: CGFloat {
        set {
            let diff = newValue - maxX
            var newOrigin = origin
            newOrigin.x += diff
            origin = newOrigin
        }
        get { return origin.x + size.width }
    }
    
    var top: CGFloat {
        set {
            var newOrigin = origin
            newOrigin.y = newValue
            origin = newOrigin
        }
        get { return origin.y }
    }
    
    var centerY: CGFloat {
        set {
            let diff = newValue - midY
            var newOrigin = origin
            newOrigin.y += diff
            origin = newOrigin
        }
        get { return origin.y + size.height / 2.0 }
    }
    
    var bottom: CGFloat {
        set {
            let diff = newValue - maxY
            var newOrigin = origin
            newOrigin.y += diff
            origin = newOrigin
        }
        get { return origin.y + size.height }
    }
    
    var center: CGPoint {
        set {
            var frame = self
            frame.origin.x = newValue.x - frame.size.width * 0.5
            frame.origin.y = newValue.y - frame.size.height * 0.5
            self = frame
        }
        get { return CGPoint(x: origin.x + size.width * 0.5, y: origin.y + size.height * 0.5) }
    }
    
    var lengthX: CGFloat {
        set {
            var newSize = size
            newSize.width = newValue
            size = newSize
        }
        get { return size.width }
    }
    
    var lengthY: CGFloat {
        set {
            var newSize = size
            newSize.height = newValue
            size = newSize
        }
        get { return size.height }
    }
}

let CGRectZero = CGRect.zero
let CGRectNull = CGRect.null
let CGRectInfinite = CGRect.infinite

/// Return center for rect
func CGRectGetCenter(_ rect: CGRect) -> CGPoint {
    return rect.center
}

func CGRectMake(origin: CGPoint = CGPoint.zero, size: CGSize) -> CGRect {
    return CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height)
}

func CGRectMake(center: CGPoint, size: CGSize) -> CGRect {
    let halfWidth = size.width / 2.0
    let halfHeight = size.height / 2.0
    return CGRect(
        x: center.x - halfWidth,
        y: center.y - halfHeight,
        width: size.width,
        height: size.height
    )
}

func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

func CGRectMake(_ x: Double, _ y: Double, _ width: Double, _ height: Double) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

func CGRectMake(_ x: Int, _ y: Int, _ width: Int, _ height: Int) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

func CGRectGetMinX(_ rect: CGRect) -> CGFloat {
    return rect.minX
}

func CGRectGetMidX(_ rect: CGRect) -> CGFloat {
    return rect.midX
}

func CGRectGetMaxX(_ rect: CGRect) -> CGFloat {
    return rect.maxX
}

func CGRectGetMinY(_ rect: CGRect) -> CGFloat {
    return rect.minY
}

func CGRectGetMidY(_ rect: CGRect) -> CGFloat {
    return rect.midY
}

func CGRectGetMaxY(_ rect: CGRect) -> CGFloat {
    return rect.maxY
}

func CGRectGetWidth(_ rect: CGRect) -> CGFloat {
    return rect.width
}

func CGRectGetHeight(_ rect: CGRect) -> CGFloat {
    return rect.height
}

func CGRectEqualToRect(_ lhs: CGRect, _ rhs: CGRect) -> Bool {
    return lhs.equalTo(rhs)
}

func CGRectStandardize(_ rect: CGRect) -> CGRect {
    return CGRect(x: abs(rect.minX), y: abs(rect.minY), width: abs(rect.width), height: abs(rect.height))
}

func CGRectIsEmpty(_ rect: CGRect) -> Bool {
    return rect.isEmpty
}

func CGRectIsNull(_ rect: CGRect) -> Bool {
    return rect.isNull
}

func CGRectIsInfinite(_ rect: CGRect) -> Bool {
    return rect.isInfinite
}

func CGRectInset(_ rect: CGRect, _ dx: CGFloat, _ dy: CGFloat) -> CGRect {
    return rect.insetBy(dx: dx, dy: dy)
}

func CGRectOffset(_ rect: CGRect, _ dx: CGFloat, _ dy: CGFloat) -> CGRect {
    return rect.offsetBy(dx: dx, dy: dy)
}

func CGRectIntegral(_ rect: CGRect) -> CGRect {
    return rect.integral
}

func CGRectUnion(_ rect1: CGRect, _ rect2: CGRect) -> CGRect {
    return rect1.union(rect2)
}

func CGRectIntersection(_ rect1: CGRect, _ rect2: CGRect) -> CGRect {
    return rect2.intersection(rect2)
}

func CGRectDivide(_ rect: CGRect, _ atDistance: CGFloat, _ from: CGRectEdge) -> (slice: CGRect, remainder: CGRect) {
    return rect.divided(atDistance: atDistance, from: from)
}

func CGRectContainsPoint(_ rect: CGRect, _ point: CGPoint) -> Bool {
    return rect.contains(point)
}

func CGRectContainsRect(_ rect1: CGRect, _ rect2: CGRect) -> Bool {
    return rect1.contains(rect2)
}

func CGRectIntersectsRect(_ rect1: CGRect, _ rect2: CGRect) -> Bool {
    return rect1.intersects(rect2)
}

// MARK: -

public extension CGAffineTransform {
    /// X scale from transform
    var xScale: CGFloat { return sqrt(a * a + c * c) }
    
    /// Y scale from transform
    var yScale: CGFloat { return sqrt(b * b + d * d) }
    
    /// Rotation in radians
    var rotation: CGFloat { return CGFloat(atan2f(Float(b), Float(a))) }
}

// MARK: -

public extension UIBezierPath {
    /// The path bounding box of `path'.
    var boundingBox: CGRect {
        return cgPath.boundingBoxOfPath
    }
    
    /// The calculated bounds taking line width into account
    var boundingWithLineBox: CGRect {
        return boundingBox.insetBy(dx: -lineWidth / 2.0, dy: -lineWidth / 2.0)
    }
    
    /// The center point for the path bounding box of `path'.
    var boundingCenter: CGPoint {
        return CGRectGetCenter(boundingBox)
    }
    
    /// Translate path’s origin to its center before applying the transform
    func centering(transform: CGAffineTransform) {
        let center = boundingCenter
        var t = CGAffineTransform.identity
        t = t.translatedBy(x: center.x, y: center.y)
        t = transform.concatenating(t)
        t = t.translatedBy(x: -center.x, y: -center.y)
        apply(t)
    }
    
    func offset(vector: CGVector) {
        centering(transform: CGAffineTransform(translationX: vector.dx, y: vector.dy))
    }
    
    func rotate(theta: CGFloat) {
        centering(transform: CGAffineTransform(rotationAngle: theta))
    }
    
    /// Move to a new center
    func moveCenter(to position: CGPoint) {
        let bounds = boundingBox
        var vector = bounds.origin.makeVector(to: position)
        vector.dx -= bounds.size.width / 2.0
        vector.dy -= bounds.size.height / 2.0
        offset(vector: vector)
    }
    
    func scale(xFactor: CGFloat, yFactor: CGFloat) {
        centering(transform: CGAffineTransform(scaleX: xFactor, y: yFactor))
    }
    
    func fit(to destRect: CGRect) {
        let bounds = boundingBox
        let fitRect = bounds.filling(in: destRect)
        let factor = min(destRect.size.width / bounds.size.width, destRect.size.height / bounds.size.height)
        moveCenter(to: fitRect.center)
        scale(xFactor: factor, yFactor: factor)
    }
    
    func horizontalInverst() {
        centering(transform: CGAffineTransform(scaleX: -1, y: 1))
    }
    
    func verticalInverst() {
        centering(transform: CGAffineTransform(scaleX: 1, y: -1))
    }
    
    class func make(string: NSString, font: UIFont) -> UIBezierPath? {
        // Initialize path
        let path = UIBezierPath()
        if (0 == string.length) {
            return path
        }
        // Create font ref
        let fontRef = CTFontCreateWithName((font.fontName as CFString?)!, font.pointSize, nil)
        // Create glyphs (that is, individual letter shapes)
        
        
        var characters = [UniChar]()
        let length = (string as NSString).length
        for i in stride(from: 0, to: length, by: 1) {
            characters.append((string as NSString).character(at: i))
        }
        
        let glyphs = UnsafeMutablePointer<CGGlyph>.allocate(capacity: length)
        glyphs.initialize(to: 0)
        
        let success = CTFontGetGlyphsForCharacters(font, characters, glyphs, length)
        if (!success) {
            print("Error retrieving string glyphs")
            free(glyphs)
            return nil
        }
        
        // Draw each char into path
        for i in 0 ..< string.length {
            // Glyph to CGPath
            let glyph = glyphs[i]
            guard let pathRef = CTFontCreatePathForGlyph(fontRef, glyph, nil) else {
                return nil
            }
            
            // Append CGPath
            path.append(UIBezierPath(cgPath: pathRef))
            
            // Offset by size
            let size = (string.substring(with: NSRange( i ..< i + 1)) as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
            path.offset(vector: CGVector(dx: -size.width, dy: 0))
        }
        
        // Clean up
        free(glyphs)
        
        // Return the path to the UIKit coordinate system MirrorPathVertically(path);
        return path
    }
    
    class func makePolygon(numberOfSides: Int) -> UIBezierPath? {
        if numberOfSides < 3 {
            print("Error: Please supply at least 3 sides")
            return nil
        }
        
        let path = UIBezierPath()
        
        // Use a unit rectangle as the destination
        let destinationRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        let center = CGRectGetCenter(destinationRect)
        let radius: CGFloat = 0.5
        
        var firstPoint = true
        for i in 0 ..< numberOfSides - 1 {
            let theta: Double = Double.pi + Double(i) * 2 * Double.pi / Double(numberOfSides)
            let dTheta: Double = 2 * Double.pi / Double(numberOfSides)
            var point = CGPoint.zero
            if firstPoint {
                point.x = center.x + radius * CGFloat(sin(theta))
                point.y = center.y + radius * CGFloat(cos(dTheta))
                firstPoint = false
            }
            point.x = center.x + radius * CGFloat(sin(theta + dTheta))
            point.y = center.y + radius * CGFloat(cos(theta + dTheta))
            
            path.addLine(to: point)
        }
        path.close()
        
        return path
    }
}

/// Query context for size and use screen scale to map from Quartz pixels to UIKit points
func UIKitGetContextSize() -> CGSize {
    guard let context = UIGraphicsGetCurrentContext() else {
        return CGSize.zero
    }
    
    let size = CGSize(
        width: CGFloat(context.width),
        height: CGFloat(context.height)
    )
    let scale: CGFloat = UIScreen.main.scale
    return CGSize(
        width: size.width / scale,
        height: size.height / scale
    )
}

public extension CGContext {
    /// Horizontal flip context by supplying the size
    func horizontalInverst(size: CGSize) {
        textMatrix = CGAffineTransform.identity
        translateBy(x: size.width, y: 0)
        scaleBy(x: -1.0, y: 1.0)
    }
    
    /// Vertical flip context by supplying the size
    func verticalInverst(size: CGSize) {
        textMatrix = CGAffineTransform.identity
        translateBy(x: 0, y: size.height)
        scaleBy(x: 1.0, y: -1.0)
    }
    
    /// Flip context by retrieving image
    @discardableResult
    func horizontalInverstImage() -> Bool {
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            horizontalInverst(size: image.size)
            return true
        }
        return false
    }
    
    /// Flip context by retrieving image
    @discardableResult
    func verticalInverstImage() -> Bool {
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            verticalInverst(size: image.size)
            return true
        }
        return false
    }
}
