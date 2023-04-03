//
//  NSObject+Extension.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/13/22.
//

import Foundation
import UIKit
extension NSObject {
    func printLog(show: Bool? = true, tag: String,msg: String) {
        print("\(tag): \(msg)")
    }
    
    func objectToData<T:Codable>(data: T) -> Data? {
        let encodedData = try? JSONEncoder().encode(data)
        return encodedData
        //   let jsonString = String(data: encodedData,
        //                           encoding: .utf8)
    }
}

extension NSObject {
    public var identifier: String {
        String(describing: type(of: self))
    }
    public static var identifier: String {
        String(describing: self)
    }
}
