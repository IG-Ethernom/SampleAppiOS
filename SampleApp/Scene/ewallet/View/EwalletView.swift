//
//  EwalletView.swift
//  SampleApp
//
//  Created by Puttheavy tep on 1/4/2566 BE.
//

import UIKit
import SkeletonView

class EwalletView: BaseView {
    override func setupView() {
        let sView = [tableView,headerView,noEwalletView]
        addSubviews(sView)
        
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        headerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            noEwalletView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            noEwalletView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            noEwalletView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            noEwalletView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
  
    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        return table
    }()
    
    var noEwalletView: NoWalletView = {
        let view = NoWalletView()
        view.isHidden = true
        return view
    }()
    
    lazy var headerView: EWalletHeaderView = {
        let view = EWalletHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.isSkeletonable = true
        return view
    }()
    
    func hideTableView(noWallet: Bool) {
        headerView.isHidden = noWallet ? true : false
        tableView.isHidden = noWallet ? true : false
        
        noEwalletView.isHidden =  noWallet ? false : true
        
         tableView.reloadData()
    }
  
}

class PinInputView: BaseView {
    override func setupUI() {
        addSubviews([pinView,descLabel])
    
        descLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        descLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        pinView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10).isActive = true
        pinView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        pinView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        pinView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
 
    lazy var descLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Please enter your pin code to verify the wallet"
        label.textColor = .black
        label.multilineLabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pinView: PasscodeView = {
        let pin = PasscodeView()
        pin.becomeFirstResponder()
       
        pin.translatesAutoresizingMaskIntoConstraints = false
        return pin
    }()
}

class EWalletHeaderView: BaseView {
    override func setupView() {
        let view = [balanceTitle, balance]
        addSubviews(view)
        balanceTitle.centerInSuperview(x: 0,y: -20)
        balance.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        balance.topAnchor.constraint(equalTo: balanceTitle.bottomAnchor, constant: 10).isActive = true
    }
    
    lazy var balanceTitle: CustomLabel = {
        let label = CustomLabel()
        label.text = "Current Balance"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
     
        return label
    }()
    
    lazy var balance: CustomLabel = {
        let label = CustomLabel()
        label.text = "$ 12.03"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.isSkeletonable = true
        label.showSkeleton()
        return label
    }()
}

class EwalletCell: BaseTableViewCell {

    override func setupview() {
        let subView = [itemView,titleLabel, iconImage]
        addSubviews(subView)
        itemView.addSubview(itemImage)
     
        let constraint = [
            itemView.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            itemView.widthAnchor.constraint(equalToConstant: 40),
            itemView.heightAnchor.constraint(equalToConstant: 40),
            
            itemImage.centerYAnchor.constraint(equalTo: itemView.centerYAnchor),
            itemImage.centerXAnchor.constraint(equalTo: itemView.centerXAnchor),
            itemImage.widthAnchor.constraint(equalToConstant: 22),
            itemImage.heightAnchor.constraint(equalToConstant: 22),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        
            iconImage.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            iconImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            iconImage.widthAnchor.constraint(equalToConstant: 22),
            iconImage.heightAnchor.constraint(equalToConstant: 22)
        ]
        
        NSLayoutConstraint.activate(constraint)
    }
   
    private lazy var itemView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var itemImage: UIImageView = {
        let label = UIImageView()
        label.image = UIImage(named: "wallet2")?.withTintColor(.gray)
        label.layer.masksToBounds = true
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Let me love you"
        label.lineBreakMode = .byTruncatingTail //Wrap the word of label
        label.font = UIFont.NunitoFont_Semibol(14)
        return label
    }()
    
    lazy var descLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = "Major Lazer, Showtek"
        label.textColor = .gray
        label.lineBreakMode = .byClipping
        label.font = UIFont.NunitoFont_Semibol(13)
        return label
    }()
    
    lazy var iconImage: UIImageView = {
        let label = UIImageView()
        label.image = UIImage(named: "arrowright2")?.withTintColor(.gray)
        label.layer.masksToBounds = true
        label.contentMode = .scaleAspectFit
        return label
    }()
}

class NoWalletView: BaseView {
    override func setupView() {
        addSubviews([EmptyWallet,createEwallet, descLabel,recoverEwallet])
        
        let height = descLabel.heightForView(text: descLabel.text!, width: UIScreen.main.bounds.width - 40)
        NSLayoutConstraint.activate([
            
            EmptyWallet.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            EmptyWallet.centerXAnchor.constraint(equalTo: centerXAnchor),
            EmptyWallet.widthAnchor.constraint(equalToConstant: 100),
            EmptyWallet.heightAnchor.constraint(equalToConstant: 100),
            
            descLabel.topAnchor.constraint(equalTo: EmptyWallet.bottomAnchor, constant: 20),
            descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            descLabel.heightAnchor.constraint(equalToConstant: height),
            
            createEwallet.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 50),
            createEwallet.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            createEwallet.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createEwallet.heightAnchor.constraint(equalToConstant: 50),

            recoverEwallet.topAnchor.constraint(equalTo: createEwallet.bottomAnchor, constant: 20),
            recoverEwallet.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            recoverEwallet.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            recoverEwallet.heightAnchor.constraint(equalToConstant: 50),
          
        ])
        
        setNeedsLayout()
    }
    
    private lazy var EmptyWallet: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "emptyBox")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.text = LanguageString.EMPTY_WALLET.LOCALIZE_STRING
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var createEwallet: UIButton = {
        let button = UIButton()
        button.title = "Create Wallet"
        button.layer.cornerRadius = 10
        button.titleColor = .white
        button.backgroundColor = .systemBlue
        return button
    }()
    
    lazy var recoverEwallet: UIButton = {
        let button = UIButton()
        button.title = "Recover Wallet"
        button.layer.cornerRadius = 10
        button.titleColor = .white
        button.backgroundColor = .systemBlue
        return button
    }()
}
