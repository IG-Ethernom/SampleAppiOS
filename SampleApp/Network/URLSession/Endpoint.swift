//
//  Endpoint.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/13/22.
//


import Foundation

//MARK: - MOCKUP API REQUEST
extension Endpoint {
    static func sts3Init(_ body: HTTPBody) -> Self {
        Endpoint(path: "/sts/initial3", method: .post(body))
    }
    
    static func stsInit(data: STSInitServerRequestBody) -> Self {
        Endpoint(path: "/sts/initial", queryItems: [URLQueryItem(name: "reqTempPublicKey", value: data.reqTempPublicKey)], method: .post(nil))
    }
}


struct Endpoint {
    private let path: String
    private let queryItems: [URLQueryItem]
    let method: HTTPMethod
    
    init(path: String, method: HTTPMethod) {
        self.path = path
        self.queryItems = []
        self.method = method
    }
    
    init(path: String, queryItems: [URLQueryItem], method: HTTPMethod) {
        self.path = path
        self.queryItems = queryItems
        self.method = method
    }
    
    private var localUrl: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "110.238.111.110"
        components.port = 8181
        components.path = path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        return components
    }
    
    private var testUrl: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "3767-202-178-125-116.ap.ngrok.io"
        components.path = path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        return components
    }
    
    private var productionUrl: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "44.235.90.155"
        components.port = 8080
        components.path = "/license_manager" + path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        return components
    }
    
    private var intergrationUrl: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        return components
    }
    
    private var mockUpAPI: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "my.api.mockaroo.com"
        components.path = path
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        return components
    }
    /**
     Base url where app will connect to
     */
    var url: URL {
        return mockUpAPI.url!
    }
    
}

struct STSInitServerRequestBody: Codable, HTTPBody {
    var reqTempPublicKey: String
    var body: Data? {
        try? JSONEncoder().encode(self)
    }
}
