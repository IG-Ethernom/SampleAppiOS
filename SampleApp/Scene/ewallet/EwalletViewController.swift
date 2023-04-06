//
//  EwalletViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 1/4/2566 BE.
//

import UIKit
import EthHFS
import SkeletonView

class EwalletViewController: BaseViewController {
    let eView = EwalletView()
    var walletAddress = ""
    var ethEwalletAPI: EthEwalletAPI?
    
    struct FeatureModel {
        var type: FeatureType
        var icon: String
    }
    
    enum FeatureType: String {
        case CHECK_BALANCE = "Check Balance"
        case SEND = "Send"
        case RECIVED = "Recieve"
        case TRANS = "Transection History"
        case WIPE = "Wipe Out"
    }
    
    var ewalletFeature = [
        FeatureModel(type: .CHECK_BALANCE, icon: "wallet2"),
        FeatureModel(type: .SEND, icon: "arrowup"),
        FeatureModel(type: .RECIVED, icon: "arrowdown"),
        FeatureModel(type: .TRANS, icon: "transactionminus"),
        FeatureModel(type: .WIPE, icon: "closesquare"),
    ]
    
    var ewalletFeatureItem: [FeatureModel] =  [] {
        didSet {
            eView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = eView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupDefaultNavigation(title: "Ewallet", tint: .black)
        
        eView.tableView.register(cellWithClass: EwalletCell.self)
        
        eView.tableView.dataSource = self
        eView.tableView.delegate = self
       
        //MARK: Extense ewallet callback
        ethEwalletAPI?.delegate = self
        
        if walletAddress == "" {
            eView.hideTableView(noWallet: true)
        }else {
            eView.hideTableView(noWallet: false)
            eView.headerView.hideSkeleton()
            ewalletFeatureItem = ewalletFeature
           
        }
        
        eView.noEwalletView.createEwallet.addTarget(self, action: #selector(createEWallet), for: .touchUpInside)
        
        eView.noEwalletView.recoverEwallet.addTarget(self, action: #selector(recoverEWallet), for: .touchUpInside)
    }
    
    override func handleBackButton() {
        self.navigationController?.backToViewController(viewController: MainViewController.self)
    }
    
    func featureItem() {
        if walletAddress == "" {
            let view = NoWalletView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            
            eView.headerView.isHidden = true
            eView.tableView.backgroundView = view
            eView.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
           
        }else {
            eView.headerView.isHidden = true
            let pinview = PinInputView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            eView.tableView.backgroundView = pinview
            eView.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
           
            pinview.pinView.didFinishedEnterCode = {[self] code in
                print("code is:\(code)")
                showLoading(message: "Verify pin")
                ethEwalletAPI?.EthVerifyPinRqst(passcode: code)
                
            }
            
        }
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

// MARK: - UITableViewDataSource
extension EwalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ewalletFeatureItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: EwalletCell.self)
        let item = ewalletFeatureItem[indexPath.row]
        
        cell.titleLabel.text = item.type.rawValue
        cell.itemImage.image = UIImage(named: item.icon)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.init(hexString: "#ECEFF1")
        cell.selectedBackgroundView = bgColorView
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension EwalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        operateFeature(item: ewalletFeature[indexPath.row])
    }
    
    func operateFeature(item: FeatureModel) {
        switch item.type {
            
        case .CHECK_BALANCE:
            break
        case .SEND:
            break
        case .RECIVED:
            break
        case .TRANS:
            break
        case .WIPE:
            showLoading(message: "Wipe out")
            ethEwalletAPI?.EthWipeOutRqst()
            break
        }
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
