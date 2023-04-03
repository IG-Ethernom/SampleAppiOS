//
//  MainViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 27/3/2566 BE.
//

import UIKit
import ETHSDK

class MainViewController: BaseViewController {
    struct FeatureModel {
        var name: FeatureType
        var icon: String
    }
    
    enum FeatureType: String {
        case EWL = "EWallet"
        case HFS = "Health File System"
        case DOB = "Device Onboard"
        case DM = "Device Manager"
    }
    
    let mainView = MainWalletView()
    var ethEwallet = EthEwalletAPI.shared
    var featureItem = [
        FeatureModel(name: .EWL, icon: "music"),
        FeatureModel(name: .HFS, icon: "star"),
        FeatureModel(name: .DOB, icon: "category"),
        FeatureModel(name: .DM, icon: "edit")
    ]
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // setupCustomNavigationBar(title: "Main Dashboard")
        
        setNavBarAppearance(tintColor: .init(hexString: .colorPrimary), barColor: .init(hexString: .colorPrimary))
        
        mainView.myCollectionView.delegate = self
        mainView.myCollectionView.dataSource = self
        mainView.myCollectionView.register(cell: MainCollectViewCells.self)
     
        navigationItem.title = "Main Dashboard"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.navigationController?.isNavigationBarHidden = true
        // remove left buttons (in case you added some)
        self.navigationItem.leftBarButtonItems = []
        // hide the default back buttons
        self.navigationItem.hidesBackButton = true
        
    }
    
    
    override func setupCustomNavigationBar(title: String) {
        
        view.addSubview(navigationMain)
        navigationMain.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: Int(navBarHeight)))
        if !title.isEmpty {
            navigationMain.titleLabel.text = title
        }
    }
    
    lazy var navigationMain: MainNavigationBarView = {
        let nav = MainNavigationBarView()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .init(hexString: .colorPrimary)
        return nav
    }()
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
        cell.titleLabel.text = item.name.rawValue
        cell.imageThumnail.image = UIImage(named: item.icon)
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width-30)/2
        return CGSize(width: width, height: 120)
    }
}
//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // delegate?.openVideoController(data: element, index: indexPath)
        operateFeature(item: featureItem[indexPath.row])
    }
    
    func operateFeature(item: FeatureModel) {
        switch item.name {
            
        case .EWL:
            //requestEwalletService()
            
            let controller = EwalletViewController()
            controller.navigationController?.isNavigationBarHidden = false
            pushToViewController(controller: controller)
            
        case .HFS:
            print("HFS")
            break
        case .DOB:
            break
        case .DM:
            break;
        }
    }
}

//MARK: ETHEWalletDataResponseDelegate
extension MainViewController: ETHEWalletDataResponseDelegate {
    func requestEwalletService() {
        //MARK: INIT EWALLET SERVICE and REQUEST EWALLET
        showLoading(message: "Ewallet Request")
        ethEwallet.initEwalletService(delegate: self, completion: { [self] in
            ethEwallet.startEwalletRequest(failure: {timeout in
                if timeout {
                    print("request timeout")
                }
            })
        })
        
    }
    
    func walletResponse(with address: WalletAdressResponse) {
        if address.status {
            // TODO: Request verify pin
            ethEwallet.verifyPinRequest(pinVerify: "222222", failure: {timeOut in
                
            })
        }
    }
    
    func verifyInputPin(_ status: Bool) {
        if status {
            // TODO: Check balance
            let controller = EwalletViewController()
            controller.navigationController?.isNavigationBarHidden = false
            pushToViewController(controller: controller)
            
        }
    }
}
