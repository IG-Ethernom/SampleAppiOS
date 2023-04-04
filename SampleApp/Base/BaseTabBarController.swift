//
//  BaseTabBarController.swift
//  CoreMVVM
//
//  Created by Puttheavy tep on 16/3/2566 BE.
//


import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupTabbar(color: UIColor) {
        // Do any additional setup after loading the view.
        UITabBarItem.appearance().badgeColor = color
        tabBar.tintColor = color
        
        tabBar.isTranslucent = true
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1)
        let borderColor = UIColor.gray.withAlphaComponent(0.2)
        topBorder.backgroundColor = borderColor.cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        tabBar.backgroundImage = UIImage(named: "tabbar_bg")
        
       // let attributes = [NSAttributedString.Key.font: AppFont.font(type: .Regular, size: 17)]
       // UINavigationBar.appearance().titleTextAttributes = attributes
       // UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        
//        let attributesTab = [NSAttributedString.Key.font: AppFont.font(type: .Regular, size: 11)]
//        UITabBarItem.appearance().setTitleTextAttributes(attributesTab, for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes(attributesTab, for: .selected)
//        UITabBarItem.appearance().setTitleTextAttributes(attributesTab, for: .application)
        
    }
    
    func setNavBarAppearance(tintColor: UIColor, barColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = barColor
        appearance.titleTextAttributes = [.foregroundColor: tintColor]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = tintColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.selectedViewController = viewControllers![2]
    }
    
    func setTitleAttribute(item: [UINavigationController]) {
        for i in item  {
            i.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NunitoFont_Semibol(11)!], for: .normal)
            
            i.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NunitoFont_Semibol(11)!], for: .selected)
        }
    }
}
