//
//  BaseView.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/12/22.
//

import UIKit
class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {}
    func setupUI() {}
}
