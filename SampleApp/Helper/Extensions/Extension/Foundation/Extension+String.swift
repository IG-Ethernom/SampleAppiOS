//
//  Extension+String.swift
//  Bamboo Consumer
//
//  Created by Puttheavy tep on 18/1/2566 BE.
//

import UIKit
extension String {
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    var trim: String {
        if self.isNotEmpty {
            return self.trimmingCharacters(in: CharacterSet.whitespaces)
        }else{
            return ""
        }
    }
    
    var trimLine: String {
        if self.isNotEmpty {
            return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }else{
            return ""
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isEmail: Bool {
        guard !self.isEmpty else{
            return false
        }
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    var isMobile: Bool {
        guard !self.isEmpty else{
            return false
        }
        let phoneRegix = "[123456789][0-9]{8}([0-9]{1})?"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegix)
        return phoneTest.evaluate(with: self)
    }
    
    func changeDate(_ mydate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.dateFormat = "yyyy/M/dd"
        let convertedDate = dateFormatter.date(from: mydate)
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let date = dateFormatter.string(from: convertedDate!)
        return date
    }
    
    //MARK : - For First Capital letter of String
    private func capitalizingFirstLetter() -> String {
        let first = String(self.prefix(1)).capitalized
        let other = String(self.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func trimWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    //MARK: - Removing space from String
    var removeSpace: String {
        if self.isNotEmpty {
            return self.components(separatedBy: .whitespaces).joined()
        }else{
            return ""
        }
    }
    
    // ======= Another Extension
    func addLocalizeString(str: String) -> String {
        let path = Bundle.main.path(forResource: str, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
  
    func trimSpaceToLowerCase() -> String {
        return self.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "")
    }
    
    public func toByteArray() -> [UInt8] {
        return Array(self.utf8)
    }

    func hexStringtoAscii() -> String {
        let pattern = "(0x)?([0-9a-f]{2})"
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let nsString = self as NSString
        let matches = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        let characters = matches.map {
            Character(UnicodeScalar(UInt32(nsString.substring(with: $0.range(at: 2)), radix: 16)!)!)
        }
        return String(characters)
    }
    
    func toFloat() -> Float {
        var toInt = Int32(_truncatingBits: strtoul(self, nil, 16)) //For Swift 5
        var float:Float32!
        memcpy(&float, &toInt, MemoryLayout.size(ofValue: float))
        return float
    }
    
    func StringFormatToDouble() -> Double {
        var amountBtc = self.replacingOccurrences(of: ".", with: ",").toDouble()
        if(amountBtc == nil) {
            amountBtc = self.replacingOccurrences(of: ",", with: ".").toDouble()
        }
        return amountBtc ?? 0
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    var hexadecimal: String {
        var data = Data(capacity: count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        
        guard data.count > 0 else { return "" }
        
        return data.hexadecimal
    }
    
    func regex (pattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
            let nsstr = self as NSString
            let all = NSRange(location: 0, length: nsstr.length)
            var matches : [String] = [String]()
            regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
                (result : NSTextCheckingResult?, _, _) in
                if let r = result {
                    let result = nsstr.substring(with: r.range) as String
                    matches.append(result)
                }
            }
            return matches
        } catch {
            return [String]()
        }
    }
    
    func matches(regex: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: [.caseInsensitive]) else { return [] }
        let matches  = regex.matches(in: self, options: [], range: NSMakeRange(0, self.count))
        return matches.map { match in
            return String(self[Range(match.range, in: self)!])
        }
    }
}

extension StringProtocol {
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { startIndex in
            guard startIndex < self.endIndex else { return nil }
            let endIndex = self.index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }
    
    public func chunked(into size: Int) -> [SubSequence] {
        var chunks: [SubSequence] = []
        
        var i = startIndex
        
        while let nextIndex = index(i, offsetBy: size, limitedBy: endIndex) {
            chunks.append(self[i ..< nextIndex])
            i = nextIndex
        }
        
        let finalChunk = self[i ..< endIndex]
        
        if finalChunk.isEmpty == false {
            chunks.append(finalChunk)
        }
        
        return chunks
    }
    
    var toAscii: [UInt8] { compactMap(\.asciiValue) }
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
    
    var hexas: [UInt8] {
        var startIndex = self.startIndex
        return stride(from: 0, to: count, by: 2).compactMap { _ in
            let endIndex = index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }
}

extension NSMutableAttributedString {
    class func getAttributedString(fromString string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string)
    }
    
    func apply(attribute: [NSAttributedString.Key: Any], subString: String)  {
        if let range = self.string.range(of: subString) {
            self.apply(attribute: attribute, onRange: NSRange(range, in: self.string))
        }
    }
    
    func apply(attribute: [NSAttributedString.Key: Any], onRange range: NSRange) {
        if range.location != NSNotFound {
            self.setAttributes(attribute, range: range)
        }
    }
    
    // Apply color on substring
    func apply(color: UIColor, subString: String) {
        
        if let range = self.string.range(of: subString) {
            self.apply(color: color, onRange: NSRange(range, in:self.string))
        }
    }
    
    // Apply color on given range
    func apply(color: UIColor, onRange: NSRange) {
        self.addAttributes([NSAttributedString.Key.foregroundColor: color],
                           range: onRange)
    }
}
