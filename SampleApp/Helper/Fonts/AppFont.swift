//
//  AppFont.swift
//  CoreMVVM
//
//  Created by Puttheavy tep on 16/3/2566 BE.
//

import Foundation
import UIKit

struct AppFont {
    enum FontType: String {
        case Bold = "Nunito-Bold"
        case Regular = "Nunito-Regular"
        case SemiBold = "Nunito-SemiBold"
    }
    static func font(type: FontType, size: CGFloat) -> UIFont{
        return UIFont(name: type.rawValue, size: size)!
    }
}


extension UIFont {
    
    class func NunitoFont_Regular(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Nunito-Regular", size: size)
    }
    
    class func NunitoFont_Semibol(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Nunito-SemiBold", size: size)
    }
    class func NunitoFont_Bold(size: CGFloat) -> UIFont? {
        return UIFont(name: "Nunito-Bold", size: size)
    }
    
}

