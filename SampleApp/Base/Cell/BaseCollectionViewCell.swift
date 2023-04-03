//
//  BaseCollectionViewCell.swift
//  Bamboo Consumer
//
//  Created by Puttheavy tep on 18/1/2566 BE.
//

import UIKit
class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
    }
}
