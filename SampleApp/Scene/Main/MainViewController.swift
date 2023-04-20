//
//  MainViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 27/3/2566 BE.
//

import UIKit
import CoreBluetooth
import EthHFSPackage

class MainViewController: BaseViewController {
    var sessionId = ""
    var shareKey = ""
    let mainView = MainWalletView()
    private var walletAddress = ""
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
       // let device = DeviceModel(deviceName: deviceInfo!.deviceName, mfgSN: deviceInfo!.mfgSN, uuid: deviceInfo!.uuid, type: 0, mtu: 0, nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            //  self.ethConnectAPI?.EthBLEDisconnect(device: device)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.gobacktoDiscover()
        })
    }
    
    func gobacktoDiscover() {
        hideLoading()
        printLog(tag: "", msg: "Disconnect from main")
      //  self.navigationController?.backToViewController(viewController: DiscoverViewController.self)
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
    
    func operateFeature(item: FeatureModel) {
        switch item.type {
            
        case .EWL:
            print("EWL")
            break;
        case .HFS:
            print("HFS")
            break
        case .DOB:
            print("DOB")
            startDeviceOnboard()
            break;
        }
    }
    
    var ethSDK = EthHFSPackage()
    func startDeviceOnboard() {
        ethSDK.InitialDeviceOnboardService(dobCallback: self, sessionId: sessionId, shareSecretKey: shareKey)
    }
    
}

extension MainViewController: _ETHDeviceOnboardDelegate {
    func companyListResponse(_ company: [CompanyResponse]) {
        print(company)
    }
    
    func deviceOnboardSucessCallback(deviceName: String, csn: String) {
        print("deviceOnboardSucessCallback")
    }
    
    func deviceOnboardFailureCallback(_ msg: String) {
        print("deviceOnboardFailureCallback")
    }
    
    
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featureItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(for: indexPath) as MainCollectViewCells
        cell.layer.cornerRadius = 15
        cell.backgroundColor = .init(hexString: .colorPrimary)
        
        // cell.layer.borderWidth = 1
        // cell.layer.borderColor = UIColor.init(hexString: .colorPrimary).cgColor
        
        
        let item = featureItem[indexPath.row]
        cell.titleLabel.text = item.name
        cell.imageThumnail.image = UIImage(named: item.icon)
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width-20)
        return CGSize(width: width, height: 100)
    }
}
//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // delegate?.openVideoController(data: element, index: indexPath)
        operateFeature(item: featureItem[indexPath.row])
    }
    
    
}

struct FeatureModel {
    var type: FeatureType
    var name: String
    var icon: String
}

enum FeatureType: String {
    case EWL = "EW"
    case HFS = "HFS"
    case DOB = "DOB"
}


var featureItem = [
    FeatureModel(type: .EWL, name: "EWallet", icon: "wallet2"),
    FeatureModel(type: .HFS, name: "Health File System", icon: "health"),
    FeatureModel(type: .DOB, name: "DOB", icon: "star")
]
