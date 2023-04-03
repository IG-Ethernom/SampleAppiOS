//
//  Extention+UINavigationController.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 19/12/2565 BE.
//

import Foundation
import UIKit

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
    
    func setWhiteStyle() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.barStyle = .default
        navigationBar.tintColor = .black
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
        ]
        navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage(named: "")
    }
    
    func setPrimaryStyle() {
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ]
        navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage(named: "")
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
            ]
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        }
        
    }

    func setClearNavbar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .white

    }

}
