//
//  Extension+Color.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/10/22.
//

import UIKit
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    convenience init?(red: Int, green: Int, blue: Int, alpha: Int = 255) {
        guard red >= 0 && red <= 255,
              green >= 0 && green <= 255,
              blue >= 0 && blue <= 255,
              alpha >= 0 && alpha <= 255 else { return nil }
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    convenience init?(_ hexString: String) {
        var str = ""
        if hexString.lowercased().hasPrefix("0x") {
            str = hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.lowercased().hasPrefix("#") {
            str = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            str = hexString
        }
        let length = str.count
        if length != 3 && length != 4 && length != 6 && length != 8 {
            return nil
        }
        if length < 5 {
            var tStr = ""
            str.forEach { tStr.append(String(repeating: $0, count: 2)) }
            str = tStr
        }
        guard let hexValue = Int(str, radix: 16) else { return nil }
        var alpha = 255
        var red = 0
        var green = 0
        var blue = 0
        if length == 3 || length == 6 {
            red = (hexValue >> 16) & 0xff
            green = (hexValue >> 8) & 0xff
            blue = hexValue & 0xff
        } else {
            red = (hexValue >> 20) & 0xff
            green = (hexValue >> 16) & 0xff
            blue = (hexValue >> 8) & 0xff
            alpha = hexValue & 0xff
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
