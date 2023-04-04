//
//  CreateWalletViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 3/4/2566 BE.
//

import UIKit

class CreateWalletViewController: BaseViewController {

    let cView = CreateWalletView()
    var pharseKey = ""
    override func loadView() {
        view = cView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .init(hexString: "#BDBDBD")
        setupDefaultNavigation(title: "Create Wallet", tint: .black)
        
        cView.pharseKeyView.titleLabel.text = pharseKey
    }
    
    override func setupDefaultNavigation(title: String, tint: UIColor? = .white) {
        let backButton = UIBarButtonItem(image: UIImage(named: "closesquare"), style: .plain, target: self, action:  #selector(handleDismiss))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = title
        
        navigationItem.leftBarButtonItem?.tintColor = tint
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
}
