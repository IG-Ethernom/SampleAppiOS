//
//  
//  AssociateDeviceViewController.swift
//  CoreiOSMVVM
//
//  Created by Puttheavy tep on 23/3/2566 BE.
//
//
import UIKit

class AssociateDeviceViewController: BaseViewController {
    var viewModel: AssociateDeviceViewModel?
    var uiView = AssociateDeviceUIView()
  
    override func loadView() {
        view = uiView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AssociateDeviceViewModel()
        
        uiView.associateButton.addTarget(self, action: #selector(self.handleAssocicateDevice), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel = nil
    }
    
    @objc func handleAssocicateDevice(_ sender: UIButton) {
        printLog(tag: "", msg: "Hi")
        let controller = QRCodeScannerController()
        controller.delegate = self
        controller.modalPresentationStyle = .fullScreen
        navigationController?.present(controller, animated: false)
    }

}

extension AssociateDeviceViewController: QRScannerCodeDelegate {
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        
    }
    
    func qrScannerDidFail(_ controller: UIViewController, error: QRCodeError) {
        
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        
    }
    
    func gotoDiscoverDevice() {
       
    }
    
}

//MARK: - HELPER FUNCTION -----
extension AssociateDeviceViewController{

}
