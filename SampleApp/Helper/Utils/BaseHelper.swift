//
//  Helper.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/13/22.
//

import UIKit
import CoreBluetooth
class BaseHelper: NSObject {
    static var shareInstance = BaseHelper()
    
    /**
     Load Countries Json File
     */
    func convertDate(unixtimeInterval: Double) -> Date {
        let date = Date(timeIntervalSince1970: unixtimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMMM dd, yyyy h:mm:ss a" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        
        let dateTime = dateFormatter.date(from: strDate)
        return dateTime!
    }
    
    func convertDateToString(date: Date, format: String? = "MMMM dd, yyyy") -> String {
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = format //yyyy-MM-dd'T'HH:mm:ss
        // Convert Date to String
        return dateFormatter.string(from: date)
    }
    
    func formatDateAndTime(date: Date) -> String {
        let formatter = DateFormatter()
        //  yyyy-MM-dd'T'HH:mm:ssZ
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MMMM dd, yyyy h:mm:ss a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        let dateString = formatter.string(from: date)
        print(dateString)
        return dateString
    }
    
    func openAppSetting() {
        let url = URL(string: UIApplication.openSettingsURLString)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    func currentTimeInMiliseconds() -> Int {
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        return Int(since1970 * 1000)
    }
    
    
}

extension Sequence {
    func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        return Dictionary.init(grouping: self, by: key)
    }
}

struct ErrorToUser {
    let code: String
    let message: String
}
