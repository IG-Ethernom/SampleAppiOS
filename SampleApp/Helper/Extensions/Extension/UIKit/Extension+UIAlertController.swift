//
//  Extension+UIAlertController.swift
//  Core_IOS_MVVM
//
//  Created by Apple on 3/4/20.
//  Copyright © 2020 Chhany. All rights reserved.
//

import UIKit
extension UIAlertController {
    struct Settings {
        var title: String?
        var message: String?
        var style: UIAlertController.Style = .alert
        var interfaceStyle: UIUserInterfaceStyle?
        var actions: [Action] = [Action()]
        var target: UIViewController?
        
        struct Action {
            var title: String? = "OK"
            var style: UIAlertAction.Style = .default
            var completion: ((UIAlertAction) -> Void)?
        }
    }
    
    /// Present alert controller
    /// - Parameters:
    ///   - settings: Alert settings
    ///   - animated: Present animated or not
    ///   - completion: Completion handler
    
    static func present(_ settings: Settings, animated: Bool = true, completion: (() -> Void)? = nil) {
        let controller = UIAlertController(title: settings.title, message: settings.message, preferredStyle: settings.style)
        controller.overrideUserInterfaceStyle = settings.interfaceStyle ?? .unspecified
        
        for action in settings.actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style, handler: action.completion)
            controller.addAction(alertAction)
        }
        
        DispatchQueue.main.async {
            let target = settings.target
            target?.present(controller, animated: animated, completion: completion)
        }
    }
    
    func hideAlertController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Core IOS MVVM", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    static func showDefaultAlert(title: String, message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LanguageString.okay.LOCALIZE_STRING, style: .cancel))
        
        if  viewController.presentedViewController == nil {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showConfirmationAlert(title: String, message: String, action: AlertAction, _ completed: @escaping (() -> Void), in viewController: UIViewController) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: LanguageString.okay.LOCALIZE_STRING, style: .default, handler: {_ in
            completed()
        })
        let exit = UIAlertAction(title: LanguageString.EXIT.LOCALIZE_STRING, style: .destructive, handler: {_ in
            
        })
        
        switch (action) {
        case .ok:
            alert.addAction(okay)
        case .exit:
            alert.addAction(exit)
            
        }
        
        if  viewController.presentedViewController == nil {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}
