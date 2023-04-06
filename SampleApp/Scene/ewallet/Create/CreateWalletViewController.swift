//
//  CreateWalletViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 3/4/2566 BE.
//

import UIKit
import EthHFS

class CreateWalletViewController: BaseViewController, ETHEWalletDataResponseDelegate{
    let cView = CreateWalletView()
    var pharseKey = ""
    var ethEwalletAPI: EthEwalletAPI?
    var walletAddress = ""
    override func loadView() {
        view = cView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .init(hexString: "#BDBDBD")
        setupDefaultNavigation(title: "Create Wallet", tint: .black)
        
        cView.pharseKeyView.titleLabel.text = pharseKey
        
        ethEwalletAPI?.delegate = self
        
        cView.descView.conButton.addTarget(self, action: #selector(handleCreate), for: .touchUpInside)
    }
   
    @objc func handleCreate() {
        gotoVerifyPin(wallet: walletAddress)
    }
    
    func gotoVerifyPin(wallet: String) {
     
        let controller = ValidatePINViewController()
        controller.navigationController?.isNavigationBarHidden = false
        controller.walletAddress = walletAddress
        controller.ethEwalletAPI = ethEwalletAPI
        controller.fromCreateWallet = true
        pushToViewController(controller: controller)
    }
    
    func deviceWasDisconnect() {
        
    }

}

