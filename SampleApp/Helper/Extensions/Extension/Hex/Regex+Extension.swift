//
//  Regex+Extension.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/13/22.
//

import Foundation
protocol RegexProtocol {
    var input: String? { get }
    var pattern: String? { get }
    var options: NSRegularExpression.Options { get }
    var matchingOptions: NSRegularExpression.MatchingOptions { get }
}

public class Regex: RegexProtocol {
    
    typealias regexBuild = (Regex) -> Void
    
    var input: String?
    var pattern: String?
    var results: [String]?
    var options: NSRegularExpression.Options = .anchorsMatchLines
    var matchingOptions: NSRegularExpression.MatchingOptions = []
    
    private var regularExpression: NSRegularExpression?
    private var checkingResult: [NSTextCheckingResult]?
    
    init(_ build: regexBuild) throws {
        build(self)
        self.regularExpression = try NSRegularExpression(pattern: pattern!, options: options)
    }
    
    func matches() -> Bool {
        guard input != nil else {
            print("Input should provided with builder")
            return false
        }
        
        return self.matches(self.input!)
    }
    
    func matches(_ input: String) -> Bool {
        self.checkingResult = regularExpression?.matches(in: self.input!,
                                                         options: matchingOptions,
                                                         range: self.getRange(of: input))
        
        if (self.checkingResult!.count > 0) {
            self.setResult()
            return true
        } else {
            return false
        }
    }
    
    func match() -> (Bool, Int) {
        guard input != nil else {
            print("Input should provided with builder")
            return (false, 0)
        }
        
        return (self.matches(self.input!), self.checkingResult!.count)
    }
    
    func match(_ input: String) -> (Bool, Int) {
        return (self.matches(input), self.checkingResult!.count)
    }
    
    private func getRange(of text: String) -> NSRange {
        return NSMakeRange(0, text.count) // Swift 4 will let call just count
    }
    
    private func setResult() {
        self.results = self.checkingResult!.map {
            return String(self.input![Range($0.range, in: self.input!)!])
        }
    }
}
