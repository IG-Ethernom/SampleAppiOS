//
//  StringExtensions.swift
//  Core_IOS_MVVM
//
//  Created by Apple on 3/4/20.
//  Copyright © 2020 Chhany. All rights reserved.
//

import UIKit
import CommonCrypto

public extension String {
    func isValid(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    func validate(_ phone: String) -> Bool {
        let phoneRegex = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result =  phoneTest.evaluate(with: phone)
        return result
    }
    /// 计算单行文本行高、支持包含emoji表情符的计算。开头空格、自定义插入的文本图片不纳入计算范围
    ///
    /// - Parameter font: 字体
    /// - Returns: 文字大小
    func singleLineSize(font: UIFont) -> CGSize {
        let cfFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        var leading = font.lineHeight - font.ascender + font.descender
        var paragraphSettings = [
            CTParagraphStyleSetting(spec: .lineSpacingAdjustment, valueSize: MemoryLayout<CGFloat>.size, value: &leading)]
        let paragraphStyle = CTParagraphStyleCreate(&paragraphSettings, 1)
        let ocString = self as NSString
        let textRange = CFRange(location: 0, length: ocString.length)
        let string = CFAttributedStringCreateMutable(kCFAllocatorDefault, ocString.length)
        CFAttributedStringReplaceString(string, CFRangeMake(0, 0), ocString)
        CFAttributedStringSetAttribute(string, textRange, kCTFontAttributeName, cfFont)
        CFAttributedStringSetAttribute(string, textRange, kCTParagraphStyleAttributeName, paragraphStyle)
        guard let lstring = string else { return CGSize.zero }
        let framesetter = CTFramesetterCreateWithAttributedString(lstring)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), nil)
    }
    /// 生成UUID
    static func UUID() -> String {
        let uuid = CFUUIDCreate(nil)
        let str = CFUUIDCreateString(nil, uuid)!
        return str as String
    }
    /// 指定字体单行高度
    ///
    /// - Parameter font: 字体
    /// - Returns: 高度
    func height(for font: UIFont) -> CGFloat {
        return size(for: font, size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), lineBreakMode: .byWordWrapping).height}
    /// 指定字体单行宽度
    ///
    /// - Parameter font: 字体
    /// - Returns: 宽度
    func width(for font: UIFont) -> CGFloat {
        return size(for: font, size: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), lineBreakMode: .byWordWrapping).width
    }
    /// 计算指定字体的尺寸
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - size: 区域大小
    ///   - lineBreakMode: 换行模式
    /// - Returns: 尺寸
    func size(for font: UIFont, size: CGSize, lineBreakMode: NSLineBreakMode) -> CGSize {
        var attr: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        if lineBreakMode != .byWordWrapping {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode
            attr[.paragraphStyle] = paragraphStyle
        }
        let rect = (self as NSString).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attr, context: nil)
        return rect.size
    }
    /// 正则匹配
    ///
    /// - Parameters:
    ///   - regex: 正则表达式
    ///   - options: 匹配选项
    /// - Returns: 是否匹配
    func matches(regex: String, options: NSRegularExpression.Options) -> Bool {
        guard let pattern = try? NSRegularExpression(pattern: regex, options: options) else { return false }
        return pattern.numberOfMatches(in: self, options: [], range: rangeOfAll) > 0
    }
    /// 正则替换
    ///
    /// - Parameters:
    ///   - regex: 正则表达式
    ///   - options: 匹配选项
    ///   - with: 待替换字符串
    /// - Returns: 新的字符串
    func replace(regex: String, options: NSRegularExpression.Options, with: String) -> String? {
        guard regex.isNotBlank else { return nil }
        guard let pattern = try? NSRegularExpression(pattern: regex, options: options) else { return nil }
        return pattern.stringByReplacingMatches(in: self, options: [], range: rangeOfAll, withTemplate: with)
    }
    func append(scale: CGFloat) -> String {
        if fabsf(Float((scale - 1))) <= .ulpOfOne || !isNotBlank || hasSuffix("/") { return self }
        return appendingFormat("@%dx", Int(scale))
    }
}

// MARK: - Path
public extension String {
    /// Documents目录路径
    static var documentsDirectoryPath: String {
        return URL.documentsDirectoryUrl.path
    }
    /// Caches目录路径
    static var cachesDirectoryPath: String {
        return URL.cachesDirectoryUrl.path
    }
    /// Library目录路径
    static var libraryDirectoryPath: String {
        return URL.libraryDirectoryUrl.path
    }
    /// tmp目录路径
    static var tmpDirectoryPath: String {
        return NSTemporaryDirectory()
    }
}

public extension String {
    /// 返回组成字符串的字符数组
    var charactersArray: [Character] {
        return Array(self)
    }
    /// 去掉字符串首尾的空格换行，中间的空格和换行忽略
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    /// 是否不为空
    ///
    /// "", "  ", "\n", "  \n   "都视为空
    /// 不为空返回true， 为空返回false
    var isNotBlank: Bool {
        return !trimmed.isEmpty
    }
    /// 字符串的全部范围
    var rangeOfAll: NSRange {
        return NSRange(location: 0, length: count)
    }
    /// NSRange转换为当前字符串的Range
    ///
    /// - Parameter range: NSRange对象
    /// - Returns: 当前字符串的范围
    func range(for range: NSRange) -> Range<String.Index>? {
        return Range(range, in: self)
    }
}

// MARK: - base64类方法
public extension String {
    /// 类方法编码base64
    ///
    /// - Parameter string: 待编码字符串
    /// - Returns: base64字符串
    static func base64Encoded(_ string: String) -> String? {
        let plainData = string.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    /// 类方法解码base64
    ///
    /// - Parameter string: 待解码字符串
    /// - Returns: 解码后的字符串
    static func base64Decoded(_ string: String) -> String? {
        guard let decodedData = Data(base64Encoded: string) else { return nil }
        return String(data: decodedData, encoding: .utf8)
    }
}
// MARK: - 验证方法
public extension String {
    /// 验证字符串是否为Email
    ///
    /// 对于是否选择支持online类邮箱可以考虑修改正则表达式结尾限制为{2,8}
    var isValidEmail: Bool {
        guard isNotBlank, let range = range(of: #"([A-Za-z0-9_\-\.])+@([A-Za-z0-9_\-\.])+.([A-Za-z]{2,4})"#,
                                        options: .regularExpression, range: nil, locale: nil),
            startIndex..<endIndex == range else {
                return false
        }
        return true
    }
    /// 针对临时邮箱（也称10分钟邮箱或一次性邮箱）的白名单验证方式
    var isValueEmailByWhitelist: Bool {
        if isValidEmail {
            let whitelist: Set = ["qq.com", "163.com", "vip.163.com", "263.net", "yeah.net", "sohu.com", "sina.cn", "sina.com", "eyou.com", "gmail.com", "hotmail.com", "42du.cn"]
            let startIndex = index(after: firstIndex(of: "@")!)
            let emailTailStr = String(self[startIndex..<endIndex])
            return whitelist.contains(emailTailStr)
        }
        return false
    }
    /// 验证字符串是否为Url
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }
}

// MARK: - 字符串插值方法
extension String.StringInterpolation {
    /// 提供 `Optional` 字符串插值
    ///
    /// 而不必强制使用 `String(describing:)`
    /// ```
    /// // There's 23 and nil
    /// "There's \(value1, default: "nil") and \(value2, default: "nil")"
    /// ```
    public mutating func appendInterpolation<T>(_ value: T?, default defaultValue: String) {
        if let value = value {
            appendInterpolation(value)
        } else {
            appendLiteral(defaultValue)
        }
    }
    public enum OptionalStyle {
        /// 有值和没有值两种情况下都包含单词 `Optional`
        case descriptive
        /// 有值和没有值两种情况下都去除单词 `Optional`
        case stripped
        /// 使用系统的插值方式，在有值时包含单词 `Optional`，没有值时则不包含
        case `default`
    }
    /// 使用提供的 `optStyle` 样式来插入可选值
    /// ```
    /// // "There's Optional(23) and nil"
    /// "There's \(value1, optStyle: .default) and \(value2, optStyle: .default)"
    ///
    /// // "There's Optional(23) and Optional(nil)"
    /// "There's \(value1, optStyle: .descriptive) and \(value2, optStyle: .descriptive)"
    /// ```
    public mutating func appendInterpolation<T>(_ value: T?, optStyle style: String.StringInterpolation.OptionalStyle) {
        switch style {
        // 有值和没有值两种情况下都包含单词 `Optional`
        case .descriptive:
            if value == nil {
                appendLiteral("Optional(nil)")
            } else {
                appendLiteral(String(describing: value))
            }
        // 有值和没有值两种情况下都去除单词 `Optional`
        case .stripped:
            if let value = value {
                appendInterpolation(value)
            } else {
                appendLiteral("nil")
            }
        // 使用系统的插值方式，在有值时包含单词 `Optional`，没有值时则不包含
        default:
            appendLiteral(String(describing: value))
        }
    }
    /// 使用 `stripped` 样式来对可选值进行插值
    /// 有值和没有值两种情况下都省略单词 `Optional`
    /// ```
    /// // "There's 23 and nil"
    /// "There's \(describing: value1) and \(describing: value2)"
    /// ```
    public mutating func appendInterpolation<T>(describing value: T?) {
        appendInterpolation(value, optStyle: .stripped)
    }
}

// 成功时包含（感谢 Nate Cook）
// MARK: - 条件成立才插值
extension String.StringInterpolation {
    /// 只有 `condition` 的返回值为 `true` 才进行插值
    /// ```
    /// // 旧写法
    /// "Cheese Sandwich \(isStarred ? "(*)" : "")"
    ///
    /// // 新写法
    /// "Cheese Sandwich \(if: isStarred, "(*)")"
    /// ```
    mutating func appendInterpolation(if condition: @autoclosure () -> Bool, _ literal: StringLiteralType) {
        guard condition() else { return }
        appendLiteral(literal)
    }
}
