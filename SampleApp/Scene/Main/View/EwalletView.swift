//
//  EwalletView.swift
//  SampleApp
//
//  Created by Puttheavy tep on 1/4/2566 BE.
//

import UIKit

class EwalletView: BaseView {
    override func setupView() {
        let sView = [tableView]
        addSubviews(sView)
        
        NSLayoutConstraint.activate([
          
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
  
    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        return table
    }()
}

class EwalletCell: BaseTableViewCell {

    override func setupview() {
        let subView = [titleLabel, descLabel]
        addSubviews(subView)
     
        let constraint = [
        
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
        
        ]
        
        NSLayoutConstraint.activate(constraint)
    }
    
    lazy var titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Let me love you"
        label.lineBreakMode = .byTruncatingTail //Wrap the word of label
        label.font = UIFont.NunitoFont_Semibol(16)
        return label
    }()
    
    lazy var descLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Major Lazer, Showtek"
        label.textColor = .gray
        label.lineBreakMode = .byClipping
        return label
    }()
    
    lazy var playTimerLabel: UIImageView = {
        let label = UIImageView()
       
        return label
    }()
}
