//
//  
//  AssociateDeviceView.swift
//  CoreiOSMVVM
//
//  Created by Puttheavy tep on 23/3/2566 BE.
//
//
import UIKit
class AssociateDeviceUIView: BaseView {
    override func setupView() {
         let sview = [ewalletLogo, titleLabel, descLabel, associateButton]
        addSubviews(sview)
        
        ewalletLogo.centerInSuperview(size: CGSize(width: 320, height: 70), y: -50)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: ewalletLogo.bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            descLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            associateButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 20),
            associateButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            associateButton.widthAnchor.constraint(equalToConstant: 300),
            associateButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private lazy var ewalletLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "e-wallet2")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true 
        return image
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setLabel(title: LanguageString.NO_ASSOCATE_DEVICE.LOCALIZE_STRING)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.setLabel(title: LanguageString.SELECT_DEVICE.LOCALIZE_STRING)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy var associateButton: UIButton = {
        let button = UIButton()
        button.title = LanguageString.ASSOCIATE_DEVICE.LOCALIZE_STRING
        button.titleColor = .black
        button.titleFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = UIColor.init(hexString: .colorPrimary)
        button.layer.cornerRadius = 30
        return button
    }()

}
