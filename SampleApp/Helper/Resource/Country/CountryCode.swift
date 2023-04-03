//
//  CountryCode.swift
//  Release Stress
//
//  Created by Puttheavy tep on 27/1/2566 BE.
//

import Foundation
extension BaseHelper {
    func getCountry() -> [Country] {
        do {
            if let bundlePath = Bundle.main.path(forResource: "countries",
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                //print(jsonData)
                return parseCountry(jsonData: jsonData)
            }
        } catch {
            print(error)
        }
        return [Country]()
    }
    
    private func parseCountry(jsonData: Data) -> [Country] {
        do {
            let decodedData = try JSONDecoder().decode([Country].self,
                                                       from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        return [Country]()
    }
}

struct Country: Codable {
    let name: String
    let dial_code: String
    let code: String
    let flag: String
}
