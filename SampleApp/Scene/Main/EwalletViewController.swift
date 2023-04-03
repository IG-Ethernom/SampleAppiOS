//
//  EwalletViewController.swift
//  SampleApp
//
//  Created by Puttheavy tep on 1/4/2566 BE.
//

import UIKit

class EwalletViewController: BaseViewController {

    let eView = EwalletView()
    
    let ewalletFeature = ["Check Balance", "Send", "Recieve", "Transection History"]
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
    }

}

// MARK: - UITableViewDataSource
extension EwalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ewalletFeature.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: EwalletCell.self)
        let item = ewalletFeature[indexPath.row]
        
        cell.titleLabel.text = item
        
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
        
    }
  
}
