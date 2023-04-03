//
//  Extension+Controller.swift
//  CoreMVVM
//
//  Created by Puttheavy tep on 16/3/2566 BE.
//

import UIKit
extension UIViewController {
    @objc func _tracking_ViewWillAppear(_ animated: Bool) {
        print("track this screen: ---- \(type(of: self))")
        _tracking_ViewWillAppear(animated)
    }
    
    static func swizzle() {
        let originalSelecctor = #selector(UIViewController.viewDidLoad)
        let swizzleSelector = #selector(UIViewController._tracking_ViewWillAppear(_:))
        guard let originalMethod = class_getInstanceMethod(self, originalSelecctor) else { return }
        guard let swizzleMethod = class_getInstanceMethod(self, swizzleSelector) else { return  }
        
        method_exchangeImplementations(originalMethod, swizzleMethod)
    }
}

