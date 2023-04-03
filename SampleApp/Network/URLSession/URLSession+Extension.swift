//
//  URLSession+Extension.swift
//  Core Bamboo
//
//  Created by Puttheavy tep on 18/1/2566 BE.
//
import UIKit
extension URLSession {
    /**
     Call this method to request to server
     
     - Parameters:
     - url: The URL for the request.
     - body: The data sent as the message body of a request, such as for an HTTP POST request.
     - timeoutInterval: The timeout interval for the request. The default is 60.0. See the commentary for the timeoutInterval for more information on timeout intervals.
     
     */
    
    func request<T:Codable>(_ endpoint: Endpoint, headers: [String: String] = ["Content-Type": "application/json"], cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 60.0,completionHandler: @escaping (T) -> Void,errorHandler: @escaping (String) -> Void) {
        print("\(endpoint.method.description) : url \(endpoint.url)")
        var request = URLRequest(url: endpoint.url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = endpoint.method.description
        request.allHTTPHeaderFields = headers
        
        switch endpoint.method {
        case .post(let body), .put(let body):
            if let body = body {
                request.httpBody = body.body
            }
        default: break
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //check for errors
            if let error = error {
                print("Error loading data! \n\(error)")
                errorHandler(error.localizedDescription)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                if statusCode <= 300 {
                    do{
                        // print("Data \(String(describing: String(data: data!, encoding: .utf8)))")
                        let result = try JSONDecoder().decode(T.self, from: data!)
                        
                        completionHandler(result)
                    }catch{
                        print("Decode failed", error, separator: " ")
                        errorHandler(error.localizedDescription)
                    }
                }else {
                    print("\(endpoint.url.absoluteString) returned bad status code: \(statusCode)!")
                    errorHandler("returned bad status code: \(statusCode)!")
                }
            }
        }
        task.resume()
    }
}


