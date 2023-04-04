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
    var ethEwallet = EthEwalletAPI.shared
    var noEwalletExist = true
    
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
    
    var ewalletFeatureItem: [FeatureModel] = [] {
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
        
        
        requestEwalletService()
    }
    
    func requestEwalletService() {
        
        //MARK: INIT EWALLET SERVICE and REQUEST EWALLET
        
        showLoading(message: "Ewallet Request")
        ethEwallet.InitEwalletService(delegate: self, failure: {timeout in
            self.printLog(tag: "", msg: "timeout")
        })
        
    }
    
    @objc func createEWallet() {
        showLoading(message: "Creating Wallet")
        ethEwallet.EthCreateWalletRqst()
       
    }
    
    @objc func recoverEWallet() {
        //TODO: Open screen to recover wallet
        showLoading(message: "Recover Wallet")
        let pharseKey = "ripple,onion,adjust,between,glass,risk,world,acoustic,jeans,panel,apart,north"
        ethEwallet.EthRecoverWalletRqst(phraseKey: pharseKey)
    }
}

// MARK: - UITableViewDataSource
extension EwalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ewalletFeatureItem.count == 0  {
            if noEwalletExist {
                let view = NoWalletView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                
               
                view.createEwallet.addTarget(self, action: #selector(createEWallet), for: .touchUpInside)
                
                view.recoverEwallet.addTarget(self, action: #selector(recoverEWallet), for: .touchUpInside)
                
                eView.headerView.isHidden = true
                eView.tableView.backgroundView = view
                eView.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
               
                return 0
            }else {
                eView.headerView.isHidden = true
                let pinview = PinInputView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                eView.tableView.backgroundView = pinview
                eView.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
               
                pinview.pinView.didFinishedEnterCode = {[self] code in
                    print("code is:\(code)")
                    showLoading(message: "Verify pin")
                    ethEwallet.EthVerifyPinRqst(passcode: code)
                    
                }
                
                return 0
            }
        }else {
            return ewalletFeatureItem.count
        }
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
            ethEwallet.EthWipeOutRqst()
            break
        }
    }
    
}

//MARK: ETHEWalletDataResponseDelegate
extension EwalletViewController: ETHEWalletDataResponseDelegate {
    func walletResponse(with address: WalletAdressResponse) {
       // print("walletResponse \(address.status) \(address.addess)")
        
        if address.status == true {
            // TODO: Request verify pin
            walletAddress = address.addess ?? ""
           
            noEwalletExist = false
            eView.tableView.reloadData()
            hideLoading()
        
        }else {
            //TODO: Create wallet request
            hideLoading()
            noEwalletExist = true
        }
    }
    
    func ewalletResponseError(_ error: ErrorCodeResponse) {
        
    }
    
    func verifyInputPinResponse(_ status: Bool) {
        print("verifyInputPin \(status)")
        hideLoading()
        if status {
            // TODO: Display feature item to perform ewallet
            ewalletFeatureItem = ewalletFeature
            noEwalletExist = false
        }
    }
    
    func createWalletSucess(address: String, pharseKey: String) {
        hideLoading()
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let con = CreateWalletViewController()
            con.pharseKey = pharseKey
            let controlller = UINavigationController(rootViewController: con)
          
            self.present(controlller, animated: true)
        })
    }
    
    func wipeoutWalletSuccess() {
        hideLoading()
    }
}
