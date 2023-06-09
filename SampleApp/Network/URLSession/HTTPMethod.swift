//
//  HTTPMethod.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/13/22.
//

import Foundation
extension Endpoint {
    enum HTTPMethod: CustomStringConvertible {
        case get
        case post(HTTPBody? = nil)
        case put(HTTPBody? = nil)
        case delete
        
        var description: String {
            switch self {
            case .get:
                return "GET"
            case .post(_):
                return "POST"
            case .put(_):
                return "PUT"
            case .delete:
                return "DELETE"
            }
        }
    }
    
}
protocol HTTPBody {
    var body: Data? { get }
}

