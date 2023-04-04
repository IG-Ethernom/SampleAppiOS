//
//  CreateWalletView.swift
//  SampleApp
//
//  Created by Puttheavy tep on 4/4/2566 BE.
//

import UIKit

class CreateWalletView: BaseView {

    override func setupUI() {
        let view = [pharseKeyView,descView]
        addSubviews(view)
        
        NSLayoutConstraint.activate([
            pharseKeyView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            pharseKeyView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            pharseKeyView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            pharseKeyView.heightAnchor.constraint(equalToConstant: 200),
            
            descView.topAnchor.constraint(equalTo: pharseKeyView.bottomAnchor, constant: 100),
            descView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            descView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            descView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    lazy var pharseKeyView: PharseKeyView = {
        let view = PharseKeyView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()

    private lazy var descView: DescCreateWalletView = {
        let view = DescCreateWalletView()
        view.backgroundColor = .init(hexString: .colorBackground)
        return view
    }()
    
}

class PharseKeyView: BaseView {
    override func setupUI() {
        let view = [titleLabel]
        addSubviews(view)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    lazy var titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "ripple onion adjust between glass risk world acoustic jeans panel apart north"
        label.textColor = .black
        label.multilineLabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
}

class DescCreateWalletView: BaseView {
    override func setupUI() {
        let view = [titleLabel, descLabel, termLabel,conButton]
        addSubviews(view)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            descLabel.heightAnchor.constraint(equalToConstant: 100),
            
            termLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            termLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            conButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            conButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            conButton.widthAnchor.constraint(equalToConstant: 150),
            conButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    lazy var titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = LanguageString.VERIFY_PHARSE_KEY.LOCALIZE_STRING
        label.textColor = .black
        label.multilineLabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    lazy var descLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = LanguageString.PLEASE_WRITE_DOWN.LOCALIZE_STRING
        label.textColor = .black
        label.multilineLabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var termLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = LanguageString.NEVER_SHARE.LOCALIZE_STRING
        label.textColor = .gray
        label.multilineLabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let conButton: UIButton = {
        let button = UIButton()
        button.title = "Continues"
        button.layer.cornerRadius = 10
        button.titleColor = .white
        button.backgroundColor = .systemBlue
        return button
    }()
}
