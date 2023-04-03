//
//  Indicator.swift
//  E-Wallet
//
//  Created by Puttheavy tep on 28/11/2565 BE.
//

import Foundation
import UIKit
public class Indicator {
    
    public static let sharedInstance = Indicator()
    var blurImg = UIImageView()
    var indicator = LoadingView()
    
    private init() {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        indicator.center = blurImg.center
    }
    
    open func showIndicator(message: String) {
        DispatchQueue.main.async {
            if let mWindow = UIWindow.key {
                self.indicator.titleLabel.text = message
                mWindow.addSubview(self.blurImg)
                mWindow.addSubview(self.indicator)
            }
            
        }
    }
    open func hideIndicator() {
        DispatchQueue.main.async( execute: {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        })
    }
}


extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
