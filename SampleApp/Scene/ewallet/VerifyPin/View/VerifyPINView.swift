//
//  VerifyPINView.swift
//  SampleApp
//
//  Created by Puttheavy tep on 29/3/2566 BE.
//

import UIKit

class VerifyPINView: BaseView {
    
    override func setupView() {
        let view = [inputPIN, verifyButton]
        addSubviews(view)
        
        inputPIN.centerInSuperview(size: CGSize(width: 200, height: 50), y: -50)
        verifyButton.topAnchor.constraint(equalTo: inputPIN.bottomAnchor, constant: 10).isActive = true
        verifyButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        verifyButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        verifyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    lazy var inputPIN: UITextField = {
        let sampleTextField =  UITextField()
        sampleTextField.placeholder = "Enter text here"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return sampleTextField
    }()
    
    lazy var verifyButton: UIButton = {
        let button = UIButton()
        button.title = "Verify"
        button.layer.cornerRadius = 10
        button.backgroundColor = .init(hexString: .colorPrimary)
        return button
    }()
}
