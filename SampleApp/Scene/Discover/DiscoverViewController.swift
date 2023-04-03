//
//  
//  DiscoverViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 24/3/2566 BE.
//
//
import UIKit
import CoreBluetooth
import ETHSDK

class DiscoverViewController: BaseViewController {
    var viewModel: DiscoverViewModel?
    var uiView = DiscoverUIView()
    
    let ethConnect = EthBLEConnectivity.share
 
    override func loadView() {
        view = uiView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DiscoverViewModel()
        
        navigationItem.title = "Discover Device"
        uiView.tableView.register(cellWithClass: DiscoverTableViewCell.self)
        uiView.tableView.delegate = self
        uiView.tableView.dataSource = self
        uiView.tableView.estimatedRowHeight = 44
        uiView.tableView.rowHeight = 80
        
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }
        
        setNavBarAppearance(tintColor: .init(hexString: .colorPrimary), barColor: .init(hexString: .colorPrimary))
    
        //MARK: - INIT ETH SDK and MAKE SCAN FRO CONNECTIVITY
        ethConnect.initBLEConnection(bleCallBackHandler: self, completion: {
            ethConnect.EthBLEScan()
        })

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel = nil
        
      // ethConnect.removeListenerCallBack(msg: "discover")
    }
  //  let device = DeviceModel(deviceName: "ETHERNOM", mfgSN: "0132141235", uuid: "", type: 0, mtu: 0, nil)
    var dataLinkDescriptor: [DeviceModel] = [DeviceModel(deviceName: "ETHERNOM", mfgSN: "0132141235", uuid: "", type: 0, mtu: 0, nil)] {
        didSet {
            uiView.tableView.reloadData()
        }
    }
    
    func requestConnectingDevice(device: DeviceModel) {
        printLog(tag: "", msg: "requestConnectingDevice \(device.deviceName)")
        
        // save current capsule device
        showLoading(message: LanguageString.CONNECTING_TO.LOCALIZE_STRING)
        ethConnect.EthBLEConnection(device: device)
    }
}

//MARK: - UITableViewDelegate - UITableViewDataSource -----
extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataLinkDescriptor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: DiscoverTableViewCell.self)
        let device = dataLinkDescriptor[indexPath.row]
        
        cell.titleLabel.text = device.deviceName
        cell.descLabel.text = "SN: \(device.mfgSN)"
        cell.versionLabel.text = device.version
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.init(hexString: "#ECEFF1")
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataLinkDescriptor[indexPath.row]
        
       // requestConnectingDevice(device: item)
        
        onConnectionDeviceReady()
    }
}


//MARK: - ETHConnectivityDeviceDelegate  -----
extension DiscoverViewController: ETHConnectivityDeviceDelegate {
    func discoverDeviceCallback(device: [ETHSDK.DeviceModel]) {
        dataLinkDescriptor = device
    }

    func onConnectionDeviceReady() {
        let controller = MainViewController()
        pushToViewController(controller: controller)
    }

    func onConnectionTimeout() {
        hideLoading()
        dataLinkDescriptor.removeAll()
        uiView.tableView.reloadData()
    
         
    }

    func disconnectDeviceCallback() {
        print("disconnectDevice from discover")
    }
  
    func onBluetoothStatus(bleOn: Bool) {
        print("onBluetoothStatus from discover")
    }
}

//MARK: - ETHEWalletDataResponseDelegate -----
extension DiscoverViewController: ETHEWalletDataResponseDelegate {

    func walletResponse(with address: WalletAdressResponse) {
        if address.status {
            // TODO: open PIN Screen
            let controller = VerifyPINViewController()
            pushToViewController(controller: controller)
        }else {
            // TODO: goto create wallet
        }
    }

    func ewalletResponseError(_ error: ETHSDK.ErrorCodeResponse) {
        printLog(tag: "", msg: "error code: \(error.code) message: \(error.message)")
    }
}
