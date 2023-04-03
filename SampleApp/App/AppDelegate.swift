//
//  AppDelegate.swift
//  Bamboo Consumer
//
//  Created by Puttheavy tep on 18/1/2566 BE.
//

import UIKit
import ETHSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        configureAppDelegate()
        
        ETHSDKManager.share.initETHService = true
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

// MARK: - configureAppDelegate
extension AppDelegate {
    func configureAppDelegate() {
      //  Thread.sleep(forTimeInterval: 1.0)
        //enable IQ keyboard
       
        UIViewController.swizzle()
    }
}