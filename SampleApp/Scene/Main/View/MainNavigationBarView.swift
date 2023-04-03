//
//  MainNavigationBarView.swift
//  SampleApp
//
//  Created by Puttheavy tep on 1/4/2566 BE.
//

import UIKit
class MainNavigationBarView: BaseView {
    override func setupView() {
        let view = [titleLabel, settingButton]
        addSubviews(view)
        
        
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        settingButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        settingButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        settingButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    lazy var titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Ethernom Categories"
        label.lineBreakMode = .byTruncatingTail //Wrap the word of label
        label.font = UIFont.NunitoFont_Semibol(20)
        label.textAlignment = .center
        return label
    }()
    
    
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        button.image = UIImage(named: "setting")?.withTintColor(.black)
       // button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
       // button.backgroundColor = .black.withAlphaComponent(0.4)
       // button.layer.cornerRadius = 25
        return button
    }()
    
}
