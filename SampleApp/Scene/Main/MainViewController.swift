//
//  MainViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 27/3/2566 BE.
//

import UIKit
import EthHFS
import CoreBluetooth

class MainViewController: BaseViewController {
    struct FeatureModel {
        var type: FeatureType
        var name: String
        var icon: String
    }
    
    enum FeatureType: String {
        case EWL = "EW"
        case HFS = "HFS"
        case NFC = "NFC"
    }
    
    let mainView = MainWalletView()
    var ethConnectAPI: EthBLEConnectivity?
    
    private var walletAddress = ""
    var featureItem = [
        FeatureModel(type: .EWL, name: "EWallet", icon: "wallet2"),
        FeatureModel(type: .HFS, name: "Health File System", icon: "health"),
        FeatureModel(type: .HFS, name: "NFC Reader", icon: "health"),
    ]
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarAppearance(tintColor: .init(hexString: .colorPrimary), barColor: .init(hexString: .colorPrimary))
    
        mainView.myCollectionView.dataSource = self
        mainView.myCollectionView.delegate = self
        
        setupDefaultNavigation(title: "Main Dashboard", tint: .black)
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)

            if parent == nil {
                debugPrint("Back Button pressed.")
                
            }
        
    }
    
    override func setupDefaultNavigation(title: String, tint: UIColor? = .white) {
        navigationItem.title = title
        let disconnect = UIBarButtonItem(image: UIImage(named: "bluetooth"), style: .plain, target: self, action:  #selector(handleDisconnectDevice))
      
        navigationItem.rightBarButtonItems = [disconnect]
    }
    
    @objc func handleDisconnectDevice() {
        showLoading(message: "Disconnecting device")
        let deviceInfo = ApplicationSession.shareInstance.getCurrentDeviceInfo()
        let device = DeviceModel(deviceName: deviceInfo!.deviceName, mfgSN: deviceInfo!.mfgSN, uuid: deviceInfo!.uuid, type: 0, mtu: 0, nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.ethConnectAPI?.EthBLEDisconnect(device: device)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.gobacktoDiscover()
        })
    }
    
    func gobacktoDiscover() {
        hideLoading()
        printLog(tag: "", msg: "Disconnect from main")
        self.navigationController?.backToViewController(viewController: DiscoverViewController.self)
    }
    
    override func enableSwap() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItems = []
        // hide the default back buttons
        self.navigationItem.hidesBackButton = true
        
    }
    
    var ethEwalletAPI: EthEwalletAPI?
    func operateFeature(item: FeatureModel) {
        switch item.type {
            
        case .EWL:
           requestEwalletService()
        case .HFS:
            print("HFS")
            break
        case .NFC:
            break
        
        }
    }
    
    func requestEwalletService() {
        //MARK: INIT EWALLET SERVICE and REQUEST EWALLET
        ethEwalletAPI = EthEwalletAPI()
        
        showLoading(message: "Ewallet Request")
        ethEwalletAPI?.InitEwalletService(delegate: self, failure: {timeout in
            self.printLog(tag: "", msg: "timeout")
        })
        
    }
    
}

extension MainViewController: ETHEWalletDataResponseDelegate {
    
    func walletAddressResponse(with address: WalletAdressResponse) {
        if address.status == true {
            // TODO: Request verify pin
            gotoVerifyPin(wallet: address.addess!)
        }else {
            //TODO: Create wallet request
            gotoewallet(walletAddress: "")
        }
    }
     
    func walletAddressResponseFailure(_ error: ErrorCodeResponse) {
        
    }
    
    func gotoVerifyPin(wallet: String) {
     
        let controller = ValidatePINViewController()
        controller.navigationController?.isNavigationBarHidden = false
        controller.walletAddress = wallet
        controller.ethEwalletAPI = ethEwalletAPI
        pushToViewController(controller: controller)
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
