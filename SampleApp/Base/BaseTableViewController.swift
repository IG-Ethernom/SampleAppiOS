//
//  BaseTableViewController.swift
//  Release Stress
//
//  Created by Puttheavy tep on 28/1/2566 BE.
//

import UIKit

class BaseTableViewController: UITableViewController{
    
    var page = 1
    var indicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .white
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        self.navigationController?.navigationBar.tintColor = .blue
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        
    }
    
    func pushAnimation() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        navigationController?.view.layer.add(transition, forKey: kCATransition)
    }
    
    func moveToLastComment() {
        if self.tableView.contentSize.height > self.tableView.frame.height {
            let lastSectionIndex = self.tableView.numberOfSections - 1
            let lastRowIndex = self.tableView.numberOfRows(inSection: lastSectionIndex) - 1
            let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
            self.tableView.scrollToRow(at: pathToLastRow as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setupCustomBackNavigation() {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    
    @objc func handleBackButton() {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    
}

