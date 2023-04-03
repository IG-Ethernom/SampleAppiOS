//
//  URLExtensions.swift
//  Core_IOS_MVVM
//
//  Created by Apple on 3/4/20.
//  Copyright © 2020 Chhany. All rights reserved.
//

import UIKit

public extension URL {
    /// Documents目录Url
    static var documentsDirectoryUrl: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    /// Caches目录Url
    static var cachesDirectoryUrl: URL {
        return try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    /// Library目录Url
    static var libraryDirectoryUrl: URL { return try! FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false) }
    /// tmp目录Url
    static var tmpDirectorUrl: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
    }
}
