//
//  ValidatePINViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 6/4/2566 BE.
//

import UIKit
import EthSDK

class ValidatePINViewController: BaseViewController {

    let pView = PinInputView()
    var walletAddress = ""
    var ethEwalletAPI: EthEwalletAPI?
    var fromCreateWallet = false
    var confirmPasscode = false
    var finalPinValue = ""
    
    override func loadView() {
        view = pView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDefaultNavigation(title: fromCreateWallet ? "Create Passcode" : "Verify Passcode")
        
        // Do any additional setup after loading the view.
        ethEwalletAPI?.delegate = self
        pView.pinView.didFinishedEnterCode = {[self] code in
            print("code is:\(code)")
            
            performPin(pinCode: code)
        }
    }
    
    
    func performPin(pinCode: String) {
        if fromCreateWallet {
            
            if !confirmPasscode {
                confirmPasscode = true
              
                finalPinValue = pinCode
                pView.descLabel.text = "Please re-enter to confirmed your passcode"
                pView.pinView.code = ""
                pView.pinView.becomeFirstResponder()
                return
            }else {
                if pinCode == finalPinValue {
                    showLoading(message: "Saving passcode")
                    print("finalPinValue \(finalPinValue)")
                    ethEwalletAPI?.EthSavePasscodeRqst(passcode: finalPinValue)
                    pView.descLabel.textColor = .black
                    pView.descLabel.text = "Please enter your pin code to verify the wallet"
                }else {
                    pView.descLabel.text = "Wrong passcode!. Please re-enter to confirmed your passcode"
                    pView.descLabel.textColor = .red
                    pView.pinView.code = ""
                    pView.pinView.becomeFirstResponder()
                }
            }
         
           
        }else {
            showLoading(message: "Verify Passcode")
        
            ethEwalletAPI?.EthVerifyPinRqst(passcode: pinCode)
        }
       
    }
    func gotoewallet(walletAddress: String) {
        hideLoading()
        let controller = EwalletViewController()
        controller.navigationController?.isNavigationBarHidden = false
        controller.walletAddress = walletAddress
        controller.ethEwalletAPI = ethEwalletAPI
        pushToViewController(controller: controller)
    }

}

extension ValidatePINViewController: ETHEWalletDataResponseDelegate {
    
     func verifyInputPinResponse(_ status: Bool) {
         print("verifyInputPin \(status)")
         hideLoading()
         if status {
             // TODO: Display feature item to perform ewallet
             gotoewallet(walletAddress: walletAddress)
         }
     }
    
    func savePinResponseSucess() {
        // TODO: Display feature item to perform ewallet
        gotoewallet(walletAddress: walletAddress)
    }
    
    func savePinResponseFailure() {
        
    }
    
    func deviceWasDisconnect() {
        
    }
     
}
