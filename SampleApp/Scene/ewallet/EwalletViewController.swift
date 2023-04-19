//
//  EwalletViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 1/4/2566 BE.
//

import UIKit
import EthSDK
import SkeletonView

class EwalletViewController: BaseViewController {
    let eView = EwalletView()
    var walletAddress = ""
    var ethEwalletAPI: EthEwalletAPI?
    
    override func loadView() {
        view = eView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupDefaultNavigation(title: "Ewallet", tint: .black)
        
        //MARK: Extense ewallet callback
        ethEwalletAPI?.delegate = self
        
        eView.noEwalletView.isHidden = walletAddress == "" ? false: true
        
        eView.walletView.isHidden = walletAddress == "" ? true: false
        eView.walletView.walletAddress.text = walletAddress
        
        eView.noEwalletView.createEwallet.addTarget(self, action: #selector(createEWallet), for: .touchUpInside)
        
        eView.noEwalletView.recoverEwallet.addTarget(self, action: #selector(recoverEWallet), for: .touchUpInside)
    }
    
    override func setupDefaultNavigation(title: String, tint: UIColor? = .white) {
        super.setupDefaultNavigation(title: title, tint: tint)
        
        if walletAddress != "" {
            let wipeout = UIBarButtonItem(image: UIImage(named: "trash"), style: .plain, target: self, action:  #selector(wipeoutwallet))
            navigationItem.rightBarButtonItem = wipeout
        }
    }
    
    override func handleBackButton() {
        self.navigationController?.backToViewController(viewController: MainViewController.self)
    }
    
    @objc func wipeoutwallet() {
        showLoading(message: "Wipeout address")
        ethEwalletAPI?.EthWipeOutRqst()
        
    }
    
    @objc func createEWallet() {
        showLoading(message: "Creating Wallet")
        ethEwalletAPI?.EthCreateWalletRqst()
        
    }
    
    @objc func recoverEWallet() {
        //TODO: Open screen to recover wallet
        showLoading(message: "Recover Wallet")
        let pharseKey = "ripple,onion,adjust,between,glass,risk,world,acoustic,jeans,panel,apart,north"
        ethEwalletAPI?.EthRecoverWalletRqst(phraseKey: pharseKey)
    }
}



//MARK: ETHEWalletDataResponseDelegate
extension EwalletViewController: ETHEWalletDataResponseDelegate {
    
    func createWalletSucess(address: String, pharseKey: String) {
        hideLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let controller = CreateWalletViewController()
            controller.pharseKey = pharseKey
            controller.walletAddress = address
            controller.ethEwalletAPI = self.ethEwalletAPI
            self.pushToViewController(controller: controller)
        })
    }
    
    func wipeoutWalletSuccess() {
        hideLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.navigationController?.backToViewController(viewController: DiscoverViewController.self)
        })
        
    }
}

extension UINavigationController {
    func backToViewController(viewController: Swift.AnyClass) {
        for element in viewControllers as Array {
            if element.isKind(of: viewController) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}
