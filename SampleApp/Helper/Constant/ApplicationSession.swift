//
//  ApplicationSession.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/10/22.
//

import Foundation
class ApplicationSession: NSObject {
    
    static var shareInstance = ApplicationSession()

    /**
     Save data as object
     */
    
    func setPhoneDefaultLanguage(value: String) {
        UserDefaults.standard.set(value, forKey: .PHONE_LANGUAGE)
    }
    func getPhoneDefaultLanguage() -> String? {
        return UserDefaults.standard.value(forKey: .PHONE_LANGUAGE) as? String
    }

}
