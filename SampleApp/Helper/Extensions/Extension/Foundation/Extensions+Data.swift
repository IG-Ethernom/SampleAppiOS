//
//  Extensions+Data.swift
//  Core_IOS_MVVM
//
//  Created by Apple on 3/4/20.
//  Copyright © 2020 Chhany. All rights reserved.
//

import UIKit
import CommonCrypto
import zlib

public extension Data {
    /// - Returns: 字符串
    func dataToString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
    /// utf8字符串
    var utf8String: String? {
        guard count > 0 else { return nil }
        return String(data: self, encoding: .utf8)
    }
    
    /// 解析Json数据
    ///
    /// - Returns: 返回解析后的对象
    func jsonValueDecoded() -> Any? {
        do {
            let result = try JSONSerialization.jsonObject(with: self, options: [])
            return result
        } catch {
            print("jsonValueDecoded error:\(error)")
        }
        return nil
    }
    func swiftToJson() -> [String: Any]? {
         do {
             // here dataResponse received from a network request
             let jsonResponse = try JSONSerialization.jsonObject(with:
                 self, options: [])
             return jsonResponse as? [String: Any]
         } catch let parsingError {
             print("Error", parsingError)
         }
         return nil
     }
}
