//
//   Date+Extension.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/13/22.
//

import Foundation
extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
    func toTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    // currenttimestamp with second value
    var currentTimeStampWithGMT:Int64 {
        Int64((self.timeIntervalSince1970 * 1000) / 1000 .rounded())
    }
    
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        
        return localDate
    }
    
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

extension Calendar {
    func todayRange() -> (Date, Date) {
        let startDate = self.startOfDay(for: Date())
        let endDate   = self.date(byAdding: .day, value: 1, to: startDate)!
        return (startDate, endDate)
    }
    
    func yesterdayRange() -> (Date, Date) {
        let endDate   = self.startOfDay(for: Date())
        let startDate = self.date(byAdding: .day, value: -1, to: endDate)!
        return (startDate, endDate)
    }
    
    func thisWeekRange() -> (Date, Date) {
        var components = DateComponents()
        components.weekday = self.firstWeekday
        
        let startDate = self.nextDate(after: Date(), matching: components, matchingPolicy: .nextTime, direction: .backward)!
        let endDate   = self.nextDate(after: startDate, matching: components, matchingPolicy: .nextTime)!
        return (startDate, endDate)
    }
    
    func thisMonthRange() -> (Date, Date) {
        var components = self.dateComponents([.era, .year, .month], from: Date())
        components.day = 1
        
        let startDate = self.date(from: components)!
        let endDate   = self.date(byAdding: .month, value: 1, to: startDate)!
        
        return (startDate, endDate)
    }
}
