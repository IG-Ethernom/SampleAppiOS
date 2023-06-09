//
//  RoundButton.swift
//  Ewallet
//
//  Created by Puttheavy tep on 24/3/2566 BE.
//

#if os(iOS)
import Foundation
import UIKit

class RoundButton: UIButton {
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        self.frame = frame
        self.tintColor = UIColor.white
        self.layer.cornerRadius = frame.size.height/2
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.contentMode = .scaleAspectFit
    }
}
#endif
