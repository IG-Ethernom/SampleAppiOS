//
//  NetworkResponse.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/13/22.
//

import Foundation
struct Response: Codable {
    let code: Int
    let message: String
}

struct ResponseModel: Codable {
    let response: Response
}
