//
//  Label.swift
//  Bamboo Consumer
//
//  Created by Puttheavy tep on 18/1/2566 BE.
//

import UIKit
extension UILabel {
    func setRequire(title: String, subTitle: String,index: Int, length: Int) -> NSMutableAttributedString {
        let titleAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        let myString = NSMutableAttributedString(string: title, attributes: titleAttribute )
        let attrString = NSAttributedString(string: subTitle)
        myString.append(attrString)
        let myRange = NSRange(location: index, length: length)
        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: myRange)
        return myString
    }
    
    func singleLineLabel(textcolor: UIColor){
        textAlignment = .left
        textColor = textcolor
        numberOfLines = 0
    }
    
    func multilineLabel(fontsize: UIFont? = UIFont.systemFont(ofSize: 16, weight: .semibold), numberOfLine: Int? = 0) {
        textAlignment = .center
        numberOfLines = numberOfLine!
        font = fontsize
        
        //To display multiple lines
        lineBreakMode = .byWordWrapping //Wrap the word of label
        
        sizeToFit()
    }
    
    func setLabel(title: String) {
        text = title
        numberOfLines = 0
        textAlignment = .center
        textColor = .black
       // font = AppFont.font(type: .Regular, size: 16)
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
    }
    
    
    func setLeft(){
        self.textAlignment = .left
    }
    
    func setRight(){
        self.textAlignment = .right
    }
    
    func attribute(_ with: String, effect: String){
        let mainString = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: self.font.fontName, size: self.font.pointSize)!]
        let effectString = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: self.font.pointSize)]
        
        let partOne = NSMutableAttributedString(string: with, attributes: mainString)
        let partTwo = NSMutableAttributedString(string: effect, attributes: effectString)
        
        let combination = NSMutableAttributedString()
        combination.append(partOne)
        combination.append(partTwo)
        self.attributedText = combination
    }
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
    
    // MARK: Extension on UILabel for adding insets - for adding padding in top, bottom, right, left.
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }
    override open var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            if let insets = padding {
                contentSize.height += insets.top + insets.bottom
                contentSize.width += insets.left + insets.right
            }
            return contentSize
        }
    }
    
}


