//
//  QRCodeError.swift
//  Ewallet
//
//  Created by Puttheavy tep on 24/3/2566 BE.
//

import Foundation

public enum QRCodeError: Error {
    case inputFailed
    case outoutFailed
    case emptyResult
}

extension QRCodeError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .inputFailed:
            return "Failed to add input."
        case .outoutFailed:
            return "Failed to add output."
        case .emptyResult:
            return "Empty string found."
        }
    }
}

extension QRCodeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .inputFailed:
            return NSLocalizedString(
                "Failed to add input.",
                comment: "Failed to add input."
            )
        case .outoutFailed:
            return NSLocalizedString(
                "Failed to add output.",
                comment: "Failed to add output."
            )
        case .emptyResult:
            return NSLocalizedString(
                "Empty string found.",
                comment: "Empty string found."
            )
        }
    }
}
