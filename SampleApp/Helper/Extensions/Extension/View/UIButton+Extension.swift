//
//  UIButton+Extension.swift
//  Bamboo Consumer
//
//  Created by Puttheavy tep on 18/1/2566 BE.
//

import UIKit

// MARK: - Property for state
extension UIButton {
    func press(completion:@escaping ((Bool) -> Void)) {
        UIView.animate(withDuration: 0.05, animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) }, completion: { (finish: Bool) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform.identity
                    completion(finish)
                })
            })
    }
    
    func setButtonClickAnimation() {
        transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
            self.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
}

public extension UIButton {
    
    var title: String? {
        get { return self.title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
    
    var titleFont: UIFont? {
        get { return titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
    
    var attributedTitle: NSAttributedString? {
        get { return self.attributedTitle(for: .normal) }
        set { setAttributedTitle(newValue, for: .normal) }
    }
    
    var titleColor: UIColor? {
        get { return self.titleColor(for: .normal) }
        set {
            setTitleColor(newValue, for: .normal)
            setTitleColor(newValue?.withAlphaComponent(0.5), for: .disabled)
            setTitleColor(newValue, for: .selected)
            if buttonType == .custom {
                setTitleColor(newValue?.withAlphaComponent(0.5), for: .highlighted)
            }
        }
    }
    
    var titleShadowColor: UIColor? {
        get { return self.titleShadowColor(for: .normal) }
        set {
            setTitleShadowColor(newValue, for: .normal)
            setTitleShadowColor(newValue?.withAlphaComponent(0.5), for: .disabled)
            setTitleShadowColor(newValue, for: .selected)
        }
    }
    
    var image: UIImage? {
        get { return self.image(for: .normal) }
        set {
            setImage(newValue?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    var selectedImage: UIImage? {
        get { return self.image(for: .selected) }
        set { setImage(newValue?.withRenderingMode(.alwaysOriginal), for: .selected) }
    }
    
    var backgroundImage: UIImage? {
        get { return self.backgroundImage(for: .normal) }
        set {
            let image = newValue?.withRenderingMode(.alwaysOriginal)
            setBackgroundImage(image, for: .normal)
            if buttonType == .custom {
                setBackgroundImage(image?.remake(alpha: 0.5), for: .highlighted)
                setBackgroundImage(image?.remake(alpha: 0.5), for: .disabled)
            }
        }
    }
    
    var selectedBackgroundImage: UIImage? {
        get { return self.backgroundImage(for: .selected) }
        set { setBackgroundImage(newValue?.withRenderingMode(.alwaysOriginal), for: .selected) }
    }
    
    var disabledBackgroundImage: UIImage? {
        get { return self.backgroundImage(for: .disabled) }
        set { setBackgroundImage(newValue?.withRenderingMode(.alwaysOriginal), for: .disabled) }
    }
}

// MARK: - Image position

public extension UIButton {
    /// Convenience `setImageAlignmentToTop:` setter.
    var imageAlignmentTopSpace: CGFloat {
        get { fatalError("Unavailable.") }
        set { setImageAlignmentToTop(titleSpace: newValue) }
    }
    
    /// Convenience `setImageAlignmentToLeft:` setter.
    var imageAlignmentLeftSpace: CGFloat {
        get { fatalError("Unavailable.") }
        set { setImageAlignmentToLeft(titleSpace: newValue) }
    }
    
    /// Convenience `setImageAlignmentToBottom:` setter.
    var imageAlignmentBottomSpace: CGFloat {
        get { fatalError("Unavailable.") }
        set { setImageAlignmentToBottom(titleSpace: newValue) }
    }
    
    /// Convenience `setImageAlignmentToRight:` setter.
    var imageAlignmentRightSpace: CGFloat {
        get { fatalError("Unavailable.") }
        set { setImageAlignmentToRight(titleSpace: newValue) }
    }
    
    /// Setup image position relate to title
    /// **NOTE**: Before invoke this methods you should setup title and image already
    func setImageAlignmentToTop(titleSpace space: CGFloat = 4.0) {
        guard let currentImage = currentImage else { return }
        guard let currentTitle = currentTitle as NSString? else { return }
        guard let titleLabel = titleLabel else { return }
        
        let halfSpace = (space / 2.0).ceilling
        let halfImageWidth = (currentImage.size.width / 2.0).ceilling
        let halfImageHeight = (currentImage.size.height / 2.0).ceilling
        titleEdgeInsets = UIEdgeInsets(
            top: halfImageHeight + halfSpace,
            left: -halfImageWidth,
            bottom: -halfImageHeight - halfSpace,
            right: halfImageWidth
        )
        
        let titleBounds = currentTitle.size(withAttributes: [.font: titleLabel.font as Any]).ceilling
        let halfEdgeWidth = (titleBounds.width / 2.0).ceilling
        let halfEdgeHeight = (titleBounds.height / 2.0).ceilling
        imageEdgeInsets = UIEdgeInsets(
            top: -halfEdgeHeight - halfSpace,
            left: halfEdgeWidth,
            bottom: halfEdgeHeight + halfSpace,
            right: -halfEdgeWidth
        )
    }
    
    /// Setup image position relate to title
    /// **NOTE**: Before invoke this methods you should setup title and image already
    func setImageAlignmentToBottom(titleSpace space: CGFloat = 4.0) {
        guard let currentImage = currentImage else { return }
        guard let currentTitle = currentTitle as NSString? else { return }
        guard let titleLabel = titleLabel else { return }
        
        let halfSpace = (space / 2.0).ceilling
        let halfImageWidth = (currentImage.size.width / 2.0).ceilling
        let halfImageHeight = (currentImage.size.height / 2.0).ceilling
        titleEdgeInsets = UIEdgeInsets(
            top: -halfImageHeight - halfSpace,
            left: -halfImageWidth,
            bottom: halfImageHeight + halfSpace,
            right: halfImageWidth
        )
        
        let titleBounds = currentTitle.size(withAttributes: [.font: titleLabel.font as Any]).ceilling
        let halfEdgeWidth = (titleBounds.width / 2.0).ceilling
        let halfEdgeHeight = (titleBounds.height / 2.0).ceilling
        imageEdgeInsets = UIEdgeInsets(
            top: halfEdgeHeight + halfSpace,
            left: halfEdgeWidth,
            bottom: -halfEdgeHeight - halfSpace,
            right: -halfEdgeWidth
        )
    }
    
    /// Setup image position relate to title
    /// **NOTE**: Before invoke this methods you should setup title and image already
    func setImageAlignmentToLeft(titleSpace space: CGFloat = 4.0) {
        let halfSpace = (space / 2.0).ceilling
        
        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: halfSpace,
            bottom: 0,
            right: -halfSpace
        )
        imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -halfSpace,
            bottom: 0,
            right: halfSpace
        )
    }
    
    /// Setup image position relate to title
    /// **NOTE**: Before invoke this methods you should setup title and image already
    func setImageAlignmentToRight(titleSpace space: CGFloat = 4.0) {
        guard let currentImage = currentImage else { return }
        guard let currentTitle = currentTitle as NSString? else { return }
        guard let titleLabel = titleLabel else { return }
        
        let halfSpace = (space / 2.0).ceilling
        let imageWidth = currentImage.size.width.ceilling
        let edgeWidth = currentTitle.size(withAttributes: [.font: titleLabel.font as Any]).width.ceilling
        
        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageWidth - halfSpace,
            bottom: 0,
            right: imageWidth + halfSpace
        )
        imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: edgeWidth + halfSpace,
            bottom: 0,
            right: -edgeWidth - halfSpace
        )
    }
}

// MARK: -

public extension UIButton {
    func performToggleSelectStateImageAnimation() {
        guard let normalImage = self.image(for: .normal) else { return }
        guard let selectedImage = self.image(for: .selected) else { return }
        guard let _imageView = imageView else { return }
        
        // Clear image
        {
            setImage(nil, for: .normal)
            setImage(nil, for: .selected)
        }()
        
        let animatedImageView = UIImageView(image: isSelected ? selectedImage : normalImage)
        animatedImageView.frame = _imageView.frame
        addSubview(animatedImageView)
        
        let recover = {
            UIView.animate(withDuration: 0.2, delay: 0, options: .beginFromCurrentState, animations: {
                animatedImageView.transform = CGAffineTransform.identity
            }, completion: { (finished: Bool) in
                self.setImage(normalImage, for: .normal)
                self.setImage(selectedImage, for: .selected)
                self.isSelected = !self.isSelected
                animatedImageView.removeFromSuperview()
            })
        }
        
        let zoomOut = {
            animatedImageView.image = !self.isSelected ? selectedImage : normalImage
            UIView.animate(withDuration: 0.2, delay: 0, options: .beginFromCurrentState, animations: {
                animatedImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { (finished: Bool) in
                recover()
            })
        }
        
        // Start with zoom in
        UIView.animate(withDuration: 0.2, delay: 0, options: .beginFromCurrentState, animations: {
            animatedImageView.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        }, completion: { (finished: Bool) in
            zoomOut()
        })
    }
}
