//
//  MainCollectViewCells.swift
//  SampleApp
//
//  Created by Puttheavy tep on 1/4/2566 BE.
//

import UIKit

class MainCollectViewCells: BaseCollectionViewCell {
    
    override func setupUI() {
        let subView = [imageThumnail, titleLabel]
        addSubviews(subView)
        
        
        imageThumnail.centerInSuperview(size: CGSize(width: 30, height: 30), y: -20)
        
        let constraint = [
            titleLabel.topAnchor.constraint(equalTo: imageThumnail.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
           // titleLabel.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        NSLayoutConstraint.activate(constraint)
    }
    
    let imageThumnail: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "category")
        return image
    }()
    
    lazy var titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Health File System"
        label.multilineLabel()
        label.font = UIFont.NunitoFont_Semibol(16)
        label.textAlignment = .center
        return label
    }()
}

