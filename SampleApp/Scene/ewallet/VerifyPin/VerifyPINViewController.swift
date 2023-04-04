//
//  VerifyPINViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 29/3/2566 BE.
//

import UIKit

class VerifyPINViewController: BaseViewController {
    let verifyView = VerifyPINView()
   // var ethWallet: ETHEWalletManager?
    
    override func loadView() {
        view = verifyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupDefaultNavigation(title: LanguageString.VERIFY_PASSCODE.LOCALIZE_STRING)
        
        verifyView.inputPIN.delegate = self
        
        verifyView.verifyButton.addTarget(self, action: #selector(handleVerify), for: .touchUpInside)
        
       // ethWallet?.delegate = self
        // ethWallet?.bluetoothDelegate = self
    }
    
    @objc func handleVerify() {
        showLoading(message: "Verify Pin")
//        ethWallet?.requestVerifyPIN(pin: verifyView.inputPIN.text ?? "", failure: {timeout in
//            print("verify pin timeout")
//        })
    }
    
}

//extension VerifyPINViewController: ETHEWalletDataResponseDelegate {
//    func verifyInputPin(_ status: Bool) {
//        hideLoading()
//        if status {
//            let controller = MainViewController()
//            pushToViewController(controller: controller)
//        }
//    }
//}

extension VerifyPINViewController {
    func disconnectDevice() {
        print("disconnectDevice")
    }
    
    func onBluetoothStatus(bleOn: Bool) {
        print("onBluetoothStatus")
    }
}

extension VerifyPINViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
}
