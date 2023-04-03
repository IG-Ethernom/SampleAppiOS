//
//  Bundle+Extension.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/13/22.
//


import Foundation
import UIKit

extension Bundle {
    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }
    
    var bundleId: String {
        return bundleIdentifier!
    }
    
    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
    
    var shortVersion: String {
        if let result = infoDictionary?["CFBundleShortVersionString"] as? String {
            return result
        } else {
            assert(false)
            return ""
        }
    }
    
    var buildVersion: String {
        if let result = infoDictionary?["CFBundleVersion"] as? String {
            return result
        } else {
            assert(false)
            return ""
        }
    }
    
    var fullVersion: String {
        return shortVersion
    }
}


public extension Bundle {
    /// 首选的屏幕缩放比例
    static var preferredScales: [CGFloat] {
        let scale = UIScreen.main.scale
        if scale <= 1.0 {
            return [1.0, 2.0, 3.0]
        } else if scale <= 2.0 {
            return [2.0, 3.0, 1.0]
        } else {
            return [3.0, 2.0, 1.0]
        }
    }
}


