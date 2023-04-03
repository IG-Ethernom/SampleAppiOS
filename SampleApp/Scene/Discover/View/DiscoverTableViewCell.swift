//
//  DiscoverTableViewCell.swift
//  SampleApp
//
//  Created by Puttheavy tep on 24/3/2566 BE.
//

import UIKit

class DiscoverTableViewCell: BaseTableViewCell {

    override func setupview() {
        let sview = [titleLabel, descLabel, versionLabel, plusImg]
        addSubviews(sview)
        
        // titleLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        descLabel.anchor(top: titleLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 0))
        
        versionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        versionLabel.trailingAnchor.constraint(equalTo: plusImg.leadingAnchor, constant: -10).isActive = true
        
        plusImg.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        plusImg.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.setLabel(title: "ETHERNOM")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.setLabel(title: "SN: 0100101010101A4")
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let versionLabel: UILabel = {
        let label = UILabel()
        label.setLabel(title: "v:0.1.33")
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let plusImg: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "add")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
}
