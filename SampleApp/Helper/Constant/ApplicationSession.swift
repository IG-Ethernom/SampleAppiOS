//
//  ApplicationSession.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/10/22.
//

import Foundation
import CoreBluetooth
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

    
    func setCurrentDeviceInfo(value: DeviceInfo) {
        UserDefaults.standard.setData(forKey: .DEVICE_INFORMATION, object: value)
    }
    
    func getCurrentDeviceInfo() -> DeviceInfo?  {
        return UserDefaults.standard.getData(forKey: .DEVICE_INFORMATION, type: DeviceInfo.self)
    }

}

class DeviceInfo: Codable {
    var deviceName: String
    var mfgSN: String
    var uuid: String
    var version: String?
    init(deviceName: String, mfgSN: String, uuid: String, version: String? = nil) {
        self.deviceName = deviceName
        self.mfgSN = mfgSN
        self.uuid = uuid
        self.version = version
    }
}
