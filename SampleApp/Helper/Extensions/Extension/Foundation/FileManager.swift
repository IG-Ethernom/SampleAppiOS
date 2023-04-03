//
//  FileManager.swift
//  Core_IOS_MVVM
//
//  Created by Apple on 3/4/20.
//  Copyright © 2020 Chhany. All rights reserved.
//

import UIKit

public extension FileManager {
    static func fileExistInMainBundle(fileName: String) -> Bool {
        return FileManager.default.fileExists(atPath: Bundle.main.bundlePath.appending("/\(fileName)"))
    }
}
