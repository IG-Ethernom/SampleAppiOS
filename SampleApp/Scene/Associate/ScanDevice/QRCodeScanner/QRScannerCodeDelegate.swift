//
//  QRScannerCodeDelegate.swift
//  Ewallet
//
//  Created by Puttheavy tep on 24/3/2566 BE.
//

#if os(iOS)
import UIKit
import Foundation

/**
 This protocol defines methods which get called when some events occures.
 */
public protocol QRScannerCodeDelegate: AnyObject {
    
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String)
    func qrScannerDidFail(_ controller: UIViewController,  error: QRCodeError)
    func qrScannerDidCancel(_ controller: UIViewController)
    func gotoDiscoverDevice()
}
#endif

extension UIImage {
    func parseQR() -> String? {
        guard let image = CIImage(image: self) else {
            return nil
        }
        let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        let features = detector?.features(in: image) ?? []
        return features.compactMap { feature in
            return (feature as? CIQRCodeFeature)?.messageString
        }.joined()
    }
}

