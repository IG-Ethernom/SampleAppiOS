//
//  UserDefaults + Extension.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/13/22.
//

import Foundation
extension UserDefaults {
    func setData<T:Encodable>(forKey: String, object: T) {
        if let encoded = try? JSONEncoder().encode(object) {
            set(encoded, forKey: forKey)
        }
    }
    
    func getData<T:Decodable>(forKey: String, type: T.Type) -> T? {
        if let data = UserDefaults.standard.data(forKey: forKey) {
            return try! JSONDecoder().decode(type.self, from: data)
        }
        return nil
    }
    
    func isNil(forKey: String) -> Bool {
        object(forKey: forKey) == nil
    }
    
    func remove(key: String) {
        removeObject(forKey: key)
    }
    
}
