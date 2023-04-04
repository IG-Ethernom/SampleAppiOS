//
//  MainViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 27/3/2566 BE.
//

import UIKit
import EthHFS

class MainViewController: BaseViewController {
    struct FeatureModel {
        var type: FeatureType
        var name: String
        var icon: String
    }
    
    enum FeatureType: String {
        case EWL = "EW"
        case HFS = "HFS"
        case DOB = "DOB"
        case DM = "DM"
        case DIS = "DIS"
    }
    
    let mainView = MainWalletView()
    private var walletAddress = ""
    var featureItem = [
        FeatureModel(type: .EWL, name: "EWallet", icon: "wallet2"),
        FeatureModel(type: .HFS, name: "Health File System", icon: "health"),
        FeatureModel(type: .DOB, name: "Device Onboard", icon: "login"),
        FeatureModel(type: .DM, name: "Device Manager", icon: "setting"),
        FeatureModel(type: .DM, name: "Device Maintenance", icon: "category"),
        FeatureModel(type: .DIS, name: "Disconnect Device", icon: "bluetooth"),
    ]
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarAppearance(tintColor: .init(hexString: .colorPrimary), barColor: .init(hexString: .colorPrimary))
        
        mainView.tableView.register(cellWithClass: EwalletCell.self)
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
        navigationItem.title = "Main Dashboard"
        
    }
    override func enableSwap() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featureItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: EwalletCell.self)
        let item = featureItem[indexPath.row]
        
        cell.titleLabel.text = item.name
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

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        operateFeature(item: featureItem[indexPath.row])
    }
    
    func operateFeature(item: FeatureModel) {
        switch item.type {
            
        case .EWL:
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
        case .DIS:
            break
        }
    }
}


