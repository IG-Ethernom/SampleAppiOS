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
import EthHFSPackage

class DiscoverViewController: BaseViewController {
    var viewModel: DiscoverViewModel?
    var uiView = DiscoverUIView()
    
    let ethConnect = EthHFSPackage()

    var goingForwards = false
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
        ethConnect.InitBLEConnection(bleCallBackHandler: self, completion: {
            ethConnect.EthBLEScan()
        })
        
       // ethConnect.delegate = self
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        goingForwards = true
        
        print("viewWillDisappear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if goingForwards {
            goingForwards = false
            
            ethConnect.EthBLEReScanDevice()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel = nil
        
    }
    
    let device = DeviceItemModel(deviceName: "ETHERNOM", mfgSN: "0132141235", uuid: "", type: 0, mtu: 0, nil)
    var dataLinkDescriptor: [DeviceItemModel] = [] {
        didSet {
            uiView.tableView.reloadData()
        }
    }
    
    func requestConnectingDevice(device: DeviceItemModel) {
        printLog(tag: "", msg: "requestConnectingDevice \(device.deviceName)")
        
        let curdevice = DeviceInfo(deviceName: device.deviceName, mfgSN: device.mfgSN, uuid: device.uuid)
        saveDevice(device: curdevice)
        // save current capsule device
        showLoading(message: LanguageString.CONNECTING_TO.LOCALIZE_STRING)
        ethConnect.EthBLESecureConnection(device: device)
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
        
         requestConnectingDevice(device: item)
        
    }
}


//MARK: - ETHConnectivityDeviceDelegate  -----
extension DiscoverViewController: _ETHConnectivityDeviceDelegate {
    func discoverDeviceCallback(device: [DeviceItemModel]) {
        dataLinkDescriptor = device
    }
    
    func onConnectionDeviceReady() {
        hideLoading()
        DispatchQueue.main.async {
            let controller = MainViewController()
            self.pushToViewController(controller: controller)
        }
    }

    func onConnectionTimeout() {
        hideLoading()
        dataLinkDescriptor.removeAll()
        uiView.tableView.reloadData()
    }

    func onDisconnectDevice() {
        print("Disconnect from discover")
        dataLinkDescriptor.removeAll()
        uiView.tableView.reloadData()
        
    }
  
    func onBluetoothStatus(bleON: Bool) {
        print("onBluetoothStatus from discover \(bleON)")
        if !bleON {
            uiView.bluetoothView.isHidden = false
            uiView.footerView.isHidden = true
        }else {
            ethConnect.EthBLEReScanDevice()
            
            uiView.footerView.isHidden = false
            uiView.bluetoothView.isHidden = true
        }
    }
   
    
    func saveDevice(device: DeviceInfo) {
        ApplicationSession.shareInstance.setCurrentDeviceInfo(value: device)
    }
}
